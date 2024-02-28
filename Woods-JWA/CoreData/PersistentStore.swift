//
//  PersistentStore.swift
//  Woods-JWA
//
//  Created by Johannes Ahlborn on 15.01.24.
//

import Foundation
import CoreData

struct PersistentStore {
    
    static let shared = PersistentStore()
    
    init() {
        container = NSPersistentContainer(name: "PlantCD")
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Error with Core Data: \(error), \(error.userInfo)")
            }
        }
    }
    
    
    
    // MARK: - Variables
    
    private let container: NSPersistentContainer
    var context: NSManagedObjectContext { container.viewContext }
    
    
    
    // MARK: - Functions
    
    func save() {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch let error as NSError {
            NSLog("Unresolved error saving context: \(error), \(error.userInfo)")
        }
    }
    
    
    func saveFavorite(plant: Plant, isFavorite: Bool) {
        let request: NSFetchRequest<PlantCD> = PlantCD.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", plant.id)

        do {
            let result = try context.fetch(request)

            if let existingPlantCD = result.first {
                // Update existing plant
                existingPlantCD.isFavorite = isFavorite
            } else {
                // Create a new plant
                let plantCD = PlantCD(context: context)
                plantCD.id = Int64(plant.id)
                plantCD.common_name = plant.common_name
                plantCD.scientific_name = plant.scientific_name
                plantCD.image_url = plant.image_url
                plantCD.isFavorite = isFavorite
            }

            save()
            print("Favorit erfolgreich gespeichert")
        } catch {
            NSLog("Fehler beim Aktualisieren des Favoritenstatus: \(error)")
        }
    }
}

