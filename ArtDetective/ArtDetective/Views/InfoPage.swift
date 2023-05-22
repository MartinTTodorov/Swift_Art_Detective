//
//  InfoPage.swift
//  ArtDetective
//
//  Created by Radolina on 17/05/2023.
//

import SwiftUI
import OpenAISwift

final class InfoPageViewModel: ObservableObject {
    private var client: OpenAISwift?

    init() {
        client = OpenAISwift(authToken: Secret.yourOpenAIAPIKey) //API key is protected, please use your own
    }

    func send(text: String, completion: @escaping (String) -> Void) {
        client?.sendCompletion(with: text, maxTokens: 500) { result in
            switch result {
            case .success(let model):
                let output = model.choices?.first?.text ?? ""
                completion(output)
            case .failure:
                break
            }
        }
    }
}


struct InfoPage: View {
    @StateObject private var viewModel = InfoPageViewModel()
    @State private var showPOV = false
    @State private var povResponse = ""

    let infoProvider = InfoProvider()
        let imageClass: String
    @State var show = false
    var body: some View {
        
        ZStack{
            NavigationView{
                
                VStack(alignment: .center){
                    
                    Image("logo")
                        .resizable()
                        .frame(width: 120, height: 120)
                    
                    Spacer()
                    
                    HStack{
                        
                        Image(systemName: "paintbrush.pointed")
                            .renderingMode(.original).resizable()
                            .frame(width: 38, height: 32)
                            .offset(x: -2)
                            .padding()
                        Text("Painting:")
                            .font(.title2)
                        Text(infoProvider.art(for: imageClass))
                            .font(.title3)
                            .bold()
                        
                    }
                    .foregroundColor(Color("LogoBlue"))
                    
                    .padding()
                    
                    
                    HStack{
                        Image(systemName: "timelapse")
                            .renderingMode(.original).resizable()
                            .frame(width: 38, height: 32)
                            .offset(x: -2)
                            .padding()
                        Text("Period:")
                            .font(.title2)
                        Text(infoProvider.artYear(for: imageClass))
                            .font(.title3)
                            .bold()
                    }
                    .foregroundColor(Color("LogoYellow"))
                    .padding()
                    HStack{
                        Image(systemName: "person")
                            .renderingMode(.original).resizable()
                            .frame(width: 38, height: 32)
                            .offset(x: -2)
                            .padding()
                        Text("Author:")
                            .font(.title2)
                        Text(infoProvider.artistName(for: imageClass))
                            .font(.title3)
                            .bold()
                    }
                    .foregroundColor(Color("LogoPurple"))
                    .padding()
                    HStack{
                        Image(systemName: "clipboard")
                            .renderingMode(.original).resizable()
                            .frame(width: 38, height: 32)
                            .offset(x: -2)
                            .padding()
                        Text("Style:")
                            .font(.title2)
                        Text(infoProvider.style(for: imageClass))
                            .font(.title3)
                            .bold()
                    }
                    .foregroundColor(Color("LogoRed"))
                    .padding()
                        Button(action:{
                            
                        withAnimation{
                            fetchPOV()
                            self.show.toggle()
                        }
                            
                        }){
                            HStack {
                                Text("See POV")
                                    .font(.title)
                                    .bold()
                                
                            }
                            
                        }
                        .buttonStyle(CreateBgStyle())
                        .padding()
                                        
                    
                }
            }
            if self.show{
                GeometryReader{_ in
                    Spacer()
                    POVView(povText: povResponse)
                }
                .padding(.top, 150)
                .background(Color.black.opacity(0.65))
                .onTapGesture {
                    withAnimation{
                        self.show.toggle()
                    }
                }
            }
        }
    }
    
    private func fetchPOV() {
        viewModel.send(text: "Give me the POV as if you are \(infoProvider.artistName(for: imageClass)) for making \(infoProvider.art(for: imageClass)) in 5 sentences, just as plain text and don't write anything else") { response in
                DispatchQueue.main.async {
                    povResponse = response
                    showPOV.toggle()
                }
            }
        }
}




struct InfoPage_Previews: PreviewProvider {
    static var previews: some View {
        InfoPage(imageClass: "The Starry Night, 1889")
    }
}


struct POVView: View {
    let povText: String

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(spacing: 12) {
                Text("Author's POV:")
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
            }
            HStack(spacing: 12) {
                Text(povText)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 50)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
    }
}
