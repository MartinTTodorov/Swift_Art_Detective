//
//  Detector.swift
//  ArtDetective
//
//  Created by Radolina on 19/05/2023.
//

import Foundation
import CoreML
import Vision
import CoreImage

struct Classifier {
    var results: String?
    
    mutating func detect(ciImage: CIImage) {
        guard let model = try? VNCoreMLModel(for: ArtClassifier(configuration: MLModelConfiguration()).model) else { return }
        
        let request = VNCoreMLRequest(model: model)
        
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        
        try? handler.perform([request])
        
        guard let results = request.results as? [VNClassificationObservation] else { return }
        
        if let firstResult = results.first, firstResult.confidence > 0.8 {
            self.results = firstResult.identifier
        }
    }
}
