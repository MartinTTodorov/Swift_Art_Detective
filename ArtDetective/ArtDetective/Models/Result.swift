//
//  Result.swift
//  ArtDetective
//
//  Created by Radolina on 20/05/2023.
//

import Foundation
import SwiftUI

struct Result: View {

let infoProvider = InfoProvider()
    let imageClass: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(infoProvider.artistName(for: imageClass))
                    .font(.system(size: 26, weight: .medium))
                
                Spacer()
                
                HStack(spacing: 5) {
                    Image(systemName: "clock")
                    Text("3 min")
                }
                .font(.system(size: 17, weight: .semibold, design: .rounded))
            }
            .opacity(0.5)

            Text(imageClass)
                .font(.system(size: 40, weight: .semibold))
            
            HStack {
                HStack {
                    Button(action: {}) {
                        Image(systemName: "heart")
                    }
                    
                    Button(action: {}) {
                        Image(systemName: "bookmark")
                    }
                    .padding(.horizontal, 15)
                                        
                    Button(action: {}) {
                        Image(systemName: "speaker.wave.2")
                    }
                    .padding(.trailing, 15)
                }
                .font(.system(size: 26, weight: .medium))
                .opacity(0.5)
                
                Button(action: {}) {
                    Text("Learn More")
                        .foregroundColor(.white)
                        .font(.system(size: 17, weight: .semibold))
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50)
                .background(.blue)
                .cornerRadius(40)
            }
            .padding(.vertical, 15)
        }
        .foregroundColor(.black)
    }
}

struct Result_Previews: PreviewProvider {
    static var previews: some View {
        Result(imageClass: "The Starry Night, 1889")
    }
}
