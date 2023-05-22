import SwiftUI
import AVFoundation

struct CameraView: View {
    @State var isPresenting: Bool = false
    @State var uiImage: UIImage?
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @State var show = false
    @StateObject var camera = CameraModel()
    @ObservedObject var classifier: ImageClassifier

    var body: some View {
        ZStack {
            CameraPreview(camera: camera)
            
            VStack {
                if camera.isTaken {
                    HStack {
                        Spacer()
                        
                        Button(action: camera.retakePhoto) {
                            Image(systemName: "arrow.triangle.2.circlepath.camera")
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        .padding(.trailing, 10)
                    }
                }
                
                Spacer()
                
                HStack {
                    if camera.isTaken {
                        Button(action: { if !camera.isSaved { camera.savePic() } }) {
                            Text(camera.isSaved ? "Saved" : "Save")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(Color.white)
                                .clipShape(Capsule())
                        }
                        .padding(.leading)
                        
                        Spacer()
                        
                        if let imageClass = classifier.imageClass {
                            InfoPage(imageClass: imageClass)
                                .frame(
                                    minWidth: 0,
                                    maxWidth: .infinity
                                )
                                .padding(30)
                        }
                                
                            
                    } else {
                        Button(action: {camera.takePic()}) {
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 65, height: 65)
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                                    .frame(width: 75, height: 75)
                            }
                        }
                    }
                }
                .frame(height: 75)
            }
        }
        .onAppear {
            camera.Check()
            
        }
        
        .sheet(isPresented: $isPresenting){
            ImagePicker(uiImage: $uiImage, isPresenting:  $isPresenting, sourceType: $sourceType)
                .onDisappear{
                    if uiImage != nil {
                        classifier.detect(uiImage: uiImage!)
                    }
                }
                
            
            
            
        }
    }
    
    
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView(classifier: ImageClassifier())
    }
}


    
    
    
    class CameraModel : NSObject, ObservableObject, AVCapturePhotoCaptureDelegate{
        @Published public var isTaken = false
        
        @Published var session = AVCaptureSession()
        
        @Published var alert = false
        
        @Published var output = AVCapturePhotoOutput()
        
        @Published var preview :  AVCaptureVideoPreviewLayer!
        
        @Published var isSaved = false
        
        @Published var picData = Data(count: 0)
        
        @Published var image : UIImage?
        
        @Published var classifier = ImageClassifier()
        
       
        
        func Check(){
            //check camera permission
            
            switch AVCaptureDevice.authorizationStatus(for: .video){
                
            case .authorized:
                setUp()
                return
                //set up sesion
            case .notDetermined:
                //permission
                AVCaptureDevice.requestAccess(for: .video){
                    (status) in
                    
                    if status{
                        
                        self.setUp()
                    }
                }
                
            case .denied:
                self.alert.toggle()
                return
            default:
                return
            }
        }
        
        func setUp(){
            do{
                self.session.beginConfiguration()
                let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back)
                
                let input = try AVCaptureDeviceInput(device: device!)
                
                //checking and adding session
                
                if self.session.canAddInput(input){
                    self.session.addInput(input)
                }
                
                if self.session.canAddOutput(self.output){
                    self.session.addOutput(self.output)
                }
                
                self.session.commitConfiguration()
            }
            catch{
                print(error.localizedDescription)
                
            }
        }
        //take and retake func
        
        func takePic(){

            DispatchQueue.global(qos: .background).async { [self] in
                self.output.capturePhoto(with: AVCapturePhotoSettings(),delegate: self)
                self.session.stopRunning()
                
                DispatchQueue.main.async {
                    
                    withAnimation{self.isTaken.toggle()}
                    
                }
                
                
                
            }

        }
        
        
        
        func retakePhoto(){
            DispatchQueue
                .global(qos: .background).async {
                    self.session.startRunning()
                    
                    DispatchQueue.main.async {
                        withAnimation{self.isTaken.toggle()}
                        
                        self.isSaved = false
                    }
                }
        }
        
        func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto,  error:Error?) {
            
            if error != nil{
                return
            }
            print("picture taken...")
            
            guard let imageData = photo.fileDataRepresentation() else{return}
            self.picData = imageData
            self.image = UIImage(data: self.picData)
            
                
        }
        
        func savePic(){
            let image = UIImage(data: self.picData)!
            
            UIImageWriteToSavedPhotosAlbum(image,nil, nil, nil)
            
            self.isSaved = true
            
            print("Pic saved")
        }
    }


struct CameraPreview: UIViewRepresentable{
    
    @ObservedObject var camera : CameraModel
    func makeUIView(context: Context) ->  UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame
        
        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)
        
        camera.session.startRunning()
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

