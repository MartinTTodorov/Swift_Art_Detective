//
//  ArtClassifier.swift
//  ArtDetective
//
//  Created by Radolina on 19/05/2023.
//

import Foundation
import SwiftUI

class ImageClassifier: ObservableObject {
    @Published private var classifier = Classifier()
    
    var imageClass: String? {
        classifier.results
    }
        
    func detect(uiImage: UIImage) {
        guard let ciImage = CIImage (image: uiImage) else { return }
        classifier.detect(ciImage: ciImage)
    }
    
    func reset() {
        classifier.results = nil
    }
}
