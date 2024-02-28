//
//  PlantCDDetailViewModel.swift
//  Woods-JWA
//
//  Created by Johannes Ahlborn on 22.01.24.
//


import SwiftUI
import PhotosUI

class PlantCDDetailViewModel: ObservableObject {
    
    private let container = PersistentStore.shared
    
    @Published var selectedImage: PhotosPickerItem?
    @Published var selectedImageData: Data?
    @Published var name = ""
   
    var disableSaving: Bool {
        name.isEmpty
    }
    
    func save() {
        let plantCDDetail = PlantCD(context: container.context)
        plantCDDetail.idCD = UUID()
        plantCDDetail.common_name = name
        plantCDDetail.imgCD = selectedImageData
        
        container.save()
    }
    func update(with plantCDViewModel: PlantCDViewModel) {
           selectedImage = plantCDViewModel.selectedImage
           selectedImageData = plantCDViewModel.selectedImageData
           name = plantCDViewModel.common_name
       }
    
}
