//
//  PlaneAnalyzer.swift
//  Planect
//
//  Created by Frederik Kohler on 27.11.24.
//

import Vision
import UIKit

struct PlaneAnalyzer {
    static func analyze(image: UIImage, completion: @escaping (Result<[Plane], PlaneAnalyzerError>) -> Void) {
        guard let model = try? VNCoreMLModel(for: PlaneModel().model) else {
            completion(.failure(.modelLoadFailed))
            return
        }

        // Bild konvertieren
        guard let ciImage = CIImage(image: image) else {
            completion(.failure(.imageConversionFailed))
            return
        }

        let request = VNCoreMLRequest(model: model) { request, error in
            if let error = error {
                completion(.failure(.analysisFailed(error.localizedDescription)))
                return
            }

            if let results = request.results as? [VNClassificationObservation] {
                let predictions = results
                    .map { Plane(type: $0.identifier, percentage: Int($0.confidence * 100)) }
                    .filter { $0.percentage >= 70 }

                completion(.success(predictions))
            } else {
                completion(.failure(.analysisFailed("Keine Vorhersage möglich.")))
            }
        }

        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let handler = VNImageRequestHandler(ciImage: ciImage)
                try handler.perform([request])
            } catch {
                completion(.failure(.analysisFailed(error.localizedDescription)))
            }
        }
    }
}  
