//
//  HomeView.swift
//  ArtDetective
//
//  Created by Radolina on 15/05/2023.
//

import SwiftUI

struct CreateBgStyle: ButtonStyle{
    func makeBody(configuration: Self.Configuration)->some View{
        configuration.label.frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(colors: [Color("LogoPurple"), Color("LogoBlue")], startPoint: .leading, endPoint: .trailing))
            .cornerRadius(15)
            .padding(.horizontal, 15)
    }
}

struct HomeView: View {
    
    var body: some View {
        NavigationView{
            VStack{
                Image("logo")
                
                NavigationLink(destination: TestScanView(classifier: ImageClassifier())){
                  
                        HStack {
                            Text("Start scaning")
                                .font(.title)
                                .bold()
                            Image(systemName: "camera")
                                .font(.title)
                                .bold()
                        }
                        
                    
                }
                .buttonStyle(CreateBgStyle())
            }
            
            
        }
        
    }
    
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
