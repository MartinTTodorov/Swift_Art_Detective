import SwiftUI
import AVFoundation


struct TestScanView: View {
    @State var isPresenting: Bool = false
    @State var uiImage: UIImage?
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @StateObject var camera = CameraModel()

    @ObservedObject var classifier: ImageClassifier
    
    var body: some View {
        
        ZStack{
            CameraPreview(camera: camera)

                .foregroundColor(.black)
                .overlay(
                    Group {
                        if uiImage != nil {
                            Image(uiImage: uiImage!)
                                .resizable()
                                .scaledToFill()
                        } else {
                            Image("Scan")
                                .resizable()
                                .scaledToFill()
                        }
                    }
                )
                    
            
            VStack{
                Spacer()
                
                VStack{
                    if let imageClass = classifier.imageClass {
                        InfoPage(imageClass: imageClass)
                            .frame(
                                minWidth: 0,
                                maxWidth: .infinity
                            )
                    }
                }
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity
                )
                .background(Color.white)
            }
        }
        .onAppear {
            uiImage = nil
            classifier.reset()
            isPresenting = true
            
        }
        .edgesIgnoringSafeArea(.all)
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
struct TestScanView_Previews: PreviewProvider {
    static var previews: some View {
        TestScanView(classifier: ImageClassifier())
    }
}
