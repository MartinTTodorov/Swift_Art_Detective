//
//  InfoPage.swift
//  ArtDetective
//
//  Created by Radolina on 17/05/2023.
//

import SwiftUI



struct InfoPage: View {
    var body: some View {
        VStack{
            
            VStack(alignment: .leading){
                Image("logo")
                    .resizable()
                .frame(width: 150, height: 150)

                Spacer()
            }
           
            HStack{
                Image(systemName: "paintpalette")
                    .font(.title)
                    .bold()
                
                    Text("Name:")
                        .font(.title2)
                    Text("Mona Lisa")
                        .font(.title3)
                        .bold()
                
                
            }
            
            HStack{
                Image(systemName: "timelapse")
                    .font(.title)
                    .bold()
                Text("Period:")
                    .font(.title2)
                Text("1400-1412")
                    .font(.title3)
                    .bold()
            }
            .padding()
            HStack{
                Image(systemName: "person.badge.minus.fill")
                    .font(.title)
                    .bold()
                Text("Author:")
                    .font(.title2)
                Text("Leonadro da Vinci")
                    .font(.title3)
                    .bold()
            }
            .padding()
            HStack{
                Image(systemName: "clipboard")
                    .font(.title)
                    .bold()
                Text("Story:")
                    .font(.title2)
                Text("Long story short")
                    .font(.title3)
                    .bold()
            }
            
            .padding()
            Button(action:{
                                  
                                    
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
}

struct InfoPage_Previews: PreviewProvider {
    static var previews: some View {
        InfoPage()
    }
}
