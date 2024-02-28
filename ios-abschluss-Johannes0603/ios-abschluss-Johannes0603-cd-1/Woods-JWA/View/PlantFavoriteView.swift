//
//  PlantFavoriteView.swift
//  Woods-JWA
//
//  Created by Johannes Ahlborn on 15.01.24.
//
/*
 import SwiftUI
 
 struct PlantFavoriteView: View {
 @ObservedObject var plantViewModel: PlantViewModel
 
 var body: some View {
 NavigationView {
 List {
 ForEach(plantViewModel.favoritePlants, id: \.id) { plant in
 Text(plant.common_name ?? "N/A")
 }
 }
 .navigationTitle("Favorite Plants")
 }
 }
 }
 */

import UniformTypeIdentifiers
import SwiftUI

struct PlantFavoriteView: View {
    @ObservedObject var viewModel: PlantViewModel
    @State private var searchText = ""
    @State private var isCaptureViewPresented = false

    var body: some View {
        NavigationView {
            List(viewModel.favoritePlants
                .filter { searchText.isEmpty || $0.common_name?.localizedCaseInsensitiveContains(searchText) == true }
                .sorted(by: { $0.common_name ?? "" < $1.common_name ?? "" }),
                 id: \.self) { plantCD in
                VStack(alignment: .leading, spacing: 8) {
                    Text(plantCD.common_name ?? "")
                        .bold()
                    Text(plantCD.scientific_name ?? "Not available")
                    
                    // Anzeigen der Bilder in der TabView
                    TabView {
                        // Hauptbild
                        if let imageURL = plantCD.image_url {
                            AsyncImage(url: imageURL) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 200, height: 200)
                            } placeholder: {
                                Image(systemName: "photo.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                            }
                        }

                        // Anzeigen von imgCD und imgCD2/3
                        if let imageData = plantCD.imgCD, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200)
                        }
                        
                        if let imgCD2Data = plantCD.imgCD2, let uiImage2 = UIImage(data: imgCD2Data) {
                            Image(uiImage: uiImage2)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200)
                        }
                        
                        if let imageData3 = plantCD.imgCD3, let uiImage3 = UIImage(data: imageData3) {
                            Image(uiImage: uiImage3)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200)
                        }

                        // Anzeigen der Bilder aus dem additionalImages-Array
                        if let additionalImages = plantCD.additionalImages {
                            ForEach(Array(additionalImages), id: \.self) { imageData in
                                if let uiImage = UIImage(data: Data([imageData])) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 200, height: 200)
                                }
                            }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .frame(height: 150)
                }
                .padding()
            }
            .onAppear {
                viewModel.fetchPlantsCD()
            }
            .navigationTitle("PlantFavoriteView")
            
            // Hintergrundbild einfügen
            .background(
                Image("Backg_details")
                    .edgesIgnoringSafeArea(.all)
            )
            
            // Suchfeld hinzufügen
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    SearchBar(text: $searchText)
                }
            }
        }
    }
}
/*
 struct PlantFavoriteView_Previews: PreviewProvider {
 static var previews: some View {
 let viewModel = PlantViewModel()
 let sampleImage = UIImage(systemName: "photo.fill")!
 return PlantFavoriteView(viewModel: viewModel)
 .environment(\.colorScheme, .dark)
 .sheet(isPresented: .constant(true)) {
 TSCameraView(image: .constant(sampleImage))
 }
 }
 }*/
