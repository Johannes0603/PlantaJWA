//
//  PlantCDListView.swift
//  Woods-JWA
//
//  Created by Johannes Ahlborn on 20.01.24.
//

import SwiftUI

struct PlantCDListView: View {
    @StateObject private var viewModel = PlantCDListViewModel()
    @State private var showAddPlant = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.filterCDPlants(), id: \.idCD) { plantCDViewModel in
                    NavigationLink(destination: PlantCDDetailView(viewModel: plantCDViewModel)) {
                        Text(plantCDViewModel.common_name)
                    }
                }
            }
            .navigationTitle("personal lexicon")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    SearchBar(text: $viewModel.searchText)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddPlant.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            .sheet(isPresented: $showAddPlant) {
                PlantCDAdd(isPresent: $showAddPlant)
            }
        }
    }
}

#Preview {
    PlantCDListView()
}
