//
//  PlantView.swift
//  Woods-JWA
//
//  Created by Johannes Ahlborn on 17.01.24.
//

import SwiftUI

struct PlantView: View {
    
    let plant: Plant
    @State private var isFavorite = false
    @State private var isSavingFavorite = false

       init(plant: Plant) {
           self.plant = plant
           self._isFavorite = State(initialValue: plant.isFavorite ?? false)
       }
    
    var body: some View {
        VStack{
            Text(plant.common_name ?? "")
                .bold()
                .padding(.bottom, 10)
            Text(plant.scientific_name ?? "Not available")
                .padding(.bottom, 10)
            HStack {
                           

                            if let imageURL = plant.image_url {
                                AsyncImage(url: imageURL) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 280)
                                } placeholder: {
                                    Image(systemName: "photo.fill")
                                }
                            } else {
                                Image(systemName: "photo.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 280)
                                    
                            }
                        }
            .border(Color.black, width: 1)
            .padding(.all, 35)
            

            Button(action: {
                isSavingFavorite = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    isFavorite.toggle()
                    PersistentStore.shared.saveFavorite(plant: plant, isFavorite: isFavorite)
                    isSavingFavorite = false
                }
                          
                        }) {
                            if isSavingFavorite {
                                ProgressView()
                            } else {
                                      Image(systemName: isFavorite ? "heart.fill" : "heart")
                                          .foregroundColor(isFavorite ? .red : .gray)
                                  }
                              }
                          }
        .padding(10)
        .background(Color.blue.opacity(0.4))
        .cornerRadius(35)
        
                      }
                  }
struct PlantView_Previews: PreviewProvider {
        static var previews: some View {
            let previewPlant = Plant(id: 125529535212, common_name: "Planta",scientific_name: "es",image_url: nil)
            PlantView(plant: previewPlant)
        }
    }

