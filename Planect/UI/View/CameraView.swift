//
//  CameraView.swift
//  Planect
//
//  Created by Frederik Kohler on 27.11.24.
//

import SwiftUI
import Vision

struct CameraView: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var posiblePlanesResults: [Plane]
    @Binding var isProcessing: Bool
    @Binding var error: String?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: CameraView

        init(_ parent: CameraView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
                parent.isProcessing = true
                parent.error = nil

                // Analyse starten
                PlaneAnalyzer.analyze(image: uiImage) { result in
                    DispatchQueue.main.async {
                        self.parent.isProcessing = false
                        
                        switch result {
                            case .success(let predictions): self.parent.posiblePlanesResults = predictions
                            case .failure(let error): self.parent.error = error.localizedDescription
                        }
                    }
                }
            }
            picker.dismiss(animated: true)
        }
    }
}
