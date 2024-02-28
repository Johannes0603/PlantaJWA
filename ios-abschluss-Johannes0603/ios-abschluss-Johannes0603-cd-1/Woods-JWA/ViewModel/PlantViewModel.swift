//
//  PlantViewModel.swift
//  Woods-JWA
//
//  Created by Johannes Ahlborn on 10.01.24.
//

import Foundation
import CoreData

class PlantViewModel: ObservableObject {
    @Published var plants: [Plant] = []
    @Published var favoritePlants: [PlantCD] = []
    @Published var search = ""
    let container = PersistentStore.shared
    
    init() {
        Task {
            await fetchPlants()
            let didSaveNotification = NSManagedObjectContext.didSaveObjectsNotification
            NotificationCenter.default.addObserver(self, selector: #selector(didSave(_:)), name: didSaveNotification, object: nil)
        }
    }
    
    func fetchPlantsCD() {
        let request = NSFetchRequest<PlantCD>(entityName: "PlantCD")
        
        do {
            favoritePlants = try container.context.fetch(request)
        } catch {
            print("error fetching: \(error)")
        }
    }
    
    @objc
    private func didSave(_ notification: Notification) {
        fetchPlantsCD()
    }
    
    func fetchPlants() async {
        do {
            if search.isEmpty {
                self.plants = try await PlantRepository.loadPlants(search: "")
            } else {
                self.plants = try await PlantRepository.loadPlants(search: search)
            }
        } catch {
            print("Error loading API", error)
        }
    }
    
}
// Map Plant objects to PlantCD objects
/*  let plantCDArray = self.plants.map { $0.toPlantCD(context: PersistentStore.shared.context) }
 
 // Update favoritePlants array on the main thread
 DispatchQueue.main.async {
 self.favoritePlants = plantCDArray
 print("Favorite Plants loaded successfully")
 }
 */
/*
 func fetchPlantsCD() async {
 do {
 let fetchedPlants = try await plantRepository.loadPlants(search: search)
 self.plants = fetchedPlants
 
 // Speichere Pflanzendaten in Core Data
 plantRepository.savePlantsToCoreData(plants: fetchedPlants)
 } catch {
 print("Fehler beim Abrufen von Pflanzendaten: \(error)")
 }
 }*/
/*
 func toggleFavorite(plant: Plant) {
            if let index = favoritePlants.firstIndex(where: { $0.id == plant.id }) {
                
                favoritePlants.remove(at: index)
            } else {
                
                favoritePlants.append(plant)
            }
        }*/

/*
import Foundation
@MainActor
class PlantViewModel: ObservableObject {
    enum HTTPError: Error {
           case invalidURL
           case invalidResponse
       }
    @Published var plants: [Plant] = []
    @Published var search = ""

    func fetchPlants(search: String) async throws {
        let encodedSearch = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        guard let url = URL(string: "https://trefle.io/api/v1/plants/search?token=QQPtbDapaVxF_AD3qkee1xtRUVMNLNRCs2tGtR4x4YI&q=\(encodedSearch)") else {
            throw HTTPError.invalidURL
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // Print the received data (for debugging purposes)
            print("Received data: \(String(data: data, encoding: .utf8) ?? "Unknown data")")
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw HTTPError.invalidResponse
            }

            struct Response: Decodable {
                let data: [Plant]
            }

            let decodedData = try JSONDecoder().decode(Response.self, from: data)
            self.plants = decodedData.data
        } catch {
            print("Error fetching or decoding data: \(error)")
            throw error
        }
    }
}
*/

