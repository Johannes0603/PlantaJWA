//
//  Plant.swift
//  Woods-JWA
//
//  Created by Johannes Ahlborn on 10.01.24.
//

import Foundation
import CoreData

struct Plant: Codable, Identifiable {
    var id: Int
    var common_name: String?
    var scientific_name: String?
    var image_url: URL?
    var isFavorite: Bool? = false
    var details: String?
    var age: String?
    var height: String?
    var specialSkill: String?
    var imgCD: Data?
    var imgCD2: Data?
    var imgCD3: Data?
    var idCD: UUID?
    var additionalImages: Set<Data>?
    
    enum CodingKeys: String, CodingKey {
        case id, common_name, scientific_name, image_url, isFavorite, additionalImages
    }
    
    // Conversion function to PlantCD
    func toPlantCD(context: NSManagedObjectContext) -> PlantCD {
        let plantCD = PlantCD(context: context)
        plantCD.id = Int64(self.id)
        plantCD.idCD = UUID()
        plantCD.common_name = self.common_name
        plantCD.scientific_name = self.scientific_name
        plantCD.image_url = self.image_url
        plantCD.isFavorite = self.isFavorite ?? false
        plantCD.details = self.details
        plantCD.age = self.age
        plantCD.height = self.height
        plantCD.specialSkill = self.specialSkill
        plantCD.imgCD = self.imgCD
        plantCD.imgCD2 = self.imgCD2
        plantCD.imgCD3 = self.imgCD3

        if let firstImageData = self.additionalImages?.first {
                   plantCD.additionalImages = firstImageData
               }

           return plantCD
       }
   }
