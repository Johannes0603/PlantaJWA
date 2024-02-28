//
//  PlantSearchView.swift
//  Woods-JWA
//
//  Created by Johannes Ahlborn on 10.01.24.
//

import SwiftUI

struct PlantSearchView: View {
    
    @StateObject private var plantViewModel = PlantViewModel()
    
    var body: some View {
        NavigationStack {
            
            ScrollView{
                
                ForEach(plantViewModel.plants, id: \.common_name){ plant in
                    PlantView(plant: plant)
                        .padding(.bottom, 20)
                }
            }
            .navigationTitle("global plant search")
            .searchable(text: $plantViewModel.search)
            .onSubmit(of: .search) {
                Task {
                    await plantViewModel.fetchPlants()
                }
            }
        }
    }
}
struct PlantSearchView_Previews: PreviewProvider {
    static var previews: some View {
        PlantSearchView()
    }
}



/*
 let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
 LazyVGrid(columns: columns, spacing: 5) {
 ForEach(plantViewModel.plants, id: \.common_name){ plant in
 PlantView(plant: plant)
 }
 }
 */
