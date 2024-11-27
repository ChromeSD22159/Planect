//
//  ContentView.swift
//  Planect
//
//  Created by Frederik Kohler on 27.11.24.
//

import SwiftUI

struct ContentScreen: View {
    @State private var showCamera = false
    @State private var image: UIImage? = nil
    @State private var posiblePlanesResults: [Plane] = []
    @State private var isProcessing: Bool = false
    @State private var error: String? = nil
    
    var body: some View {
        VStack {
            Text("Planespotter")
                .font(.largeTitle)
                .padding()

            // Bild anzeigen
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 300)
                    .overlay(Text("Kein Bild aufgenommen").foregroundColor(.gray))
            }

            // Ergebnis oder Fehler anzeigen
            if let error = error {
                Text(error)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                    .padding()
            } else if isProcessing {
                ProgressView("Analysiere...")
                    .padding()
            } else if posiblePlanesResults.isEmpty {
                Text("Keine Ergebnisse verfügbar.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List(posiblePlanesResults, id: \.type) { plane in
                    HStack {
                        Text("\(plane.type)")
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Text("\(plane.percentage)%")
                            .fontWeight(.bold)
                    }
                }
            }

            // Kamera öffnen Button
            Button(action: {
                showCamera = true
            }) {
                Text("Kamera öffnen")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $showCamera) {
                CameraView(
                    image: $image,
                    posiblePlanesResults: $posiblePlanesResults,
                    isProcessing: $isProcessing,
                    error: $error
                )
            }
        }
        .padding()
    }
}
  
#Preview {
    ContentScreen()
}
