//
//  InfoPage.swift
//  ArtDetective
//
//  Created by Radolina on 17/05/2023.
//

import SwiftUI



struct InfoPage: View {
    
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
                        Text("Author:")
                            .font(.title2)
                        Text("Leonadro da Vinci")
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
                        Text("1400-1412")
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
                        Text("Leonadro da Vinci")
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
                        Text("Story:")
                            .font(.title2)
                        Text("Long story short")
                            .font(.title3)
                            .bold()
                    }
                    .foregroundColor(Color("LogoRed"))
                    .padding()
                        Button(action:{
                        withAnimation{
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
                    POVView()
                }
                .background(Color.black.opacity(0.65))
                .onTapGesture {
                    withAnimation{
                        self.show.toggle()
                    }
                }
            }
        }
        
    }
}

struct InfoPage_Previews: PreviewProvider {
    static var previews: some View {
        InfoPage()
    }
}


struct POVView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15){
            HStack(spacing:12) {
                Text("Authors POV:")
                        .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
            }
            HStack (spacing:12){
                Text("Ah, the Mona Lisa! A tale woven with strokes of artistic brilliance and a touch of mystery. Listen closely, for I shall reveal to you the secrets behind my creation.")
                    .multilineTextAlignment(.center)
                    .padding()
            }
           
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
    }
}
