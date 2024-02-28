//
//  PlantCDAdd.swift
//  Woods-JWA
//
//  Created by Johannes Ahlborn on 20.01.24.
//
import SwiftUI
import PhotosUI

struct PlantCDAdd: View {
    
    @StateObject private var viewModel = PlantCDAddViewModel()
    @Binding var isPresent: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $viewModel.common_name)
                    TextField("Text mit Infos zur Pflanze", text: $viewModel.details)
                }
                
                Section {
                    VStack {
                        // Bildvorschau für Bild 1
                        if let image1 = viewModel.image1 {
                            Image(uiImage: image1)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 200)
                        }
                        
                        // Bildauswahl für Bild 1
                        PhotosPicker(selection: $viewModel.selectedImage1, matching: .images, photoLibrary: .shared()) {
                            Text("Foto für Bild 1 auswählen")
                        }
                        .onChange(of: viewModel.selectedImage1) { newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    viewModel.selectedImageData1 = data
                                }
                            }
                        }
                    }
                }
                
                Section {
                    VStack {
                        // Bildvorschau für Bild 2
                        if let image2 = viewModel.image2 {
                            Image(uiImage: image2)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 200)
                        }
                        
                        // Bildauswahl für Bild 2
                        PhotosPicker(selection: $viewModel.selectedImage2, matching: .images, photoLibrary: .shared()) {
                            Text("Foto für Bild 2 auswählen")
                        }
                        .onChange(of: viewModel.selectedImage2) { newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    viewModel.selectedImageData2 = data
                                }
                            }
                        }
                    }
                }
                
                Section {
                    Button(action: addNew) {
                        Text("Hinzufügen")
                    }
                    .disabled(viewModel.disableButton)
                }
            }
        }
    }
    
    private func addNew() {
        viewModel.addPlantCD()
        dissmissView()
    }
    
    private func dissmissView() {
        isPresent.toggle()
    }
}

#Preview {
    PlantCDAdd(isPresent: .constant(false))
}
