//
//  PlantAddViewModel.swift
//  Woods-JWA
//
//  Created by Johannes Ahlborn on 20.01.24.
//
import Foundation
import SwiftUI
import PhotosUI

class PlantCDAddViewModel: ObservableObject {
    
    // MARK: - Variables
    
    let container = PersistentStore.shared
    
    @Published var common_name = ""
    @Published var details = ""
    @Published var scientific_name = ""
    
    @Published var selectedImage1: PhotosPickerItem?
    @Published var selectedImageData1: Data?
    @Published var image1: UIImage?
    
    @Published var selectedImage2: PhotosPickerItem?
    @Published var selectedImageData2: Data?
    @Published var image2: UIImage?
    
    var disableButton: Bool {
        return common_name.isEmpty || details.isEmpty
    }
    
    
    func addPlantCD() {
        let plantcd = PlantCD(context: PersistentStore.shared.context)
        plantcd.idCD = UUID()
        plantcd.common_name = common_name
        plantcd.details = details
        plantcd.isFavorite = true
        plantcd.scientific_name = scientific_name
        plantcd.imgCD = selectedImageData1
        plantcd.imgCD2 = selectedImageData2
        
        container.save()
    }
}
