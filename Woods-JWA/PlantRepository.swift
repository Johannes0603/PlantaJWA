//
//  PlantRepository.swift
//  Woods-JWA
//
//  Created by Johannes Ahlborn on 10.01.24.
//

/*
import Foundation

class PlantRepository {
    
    static func fetchPlants(search: String) async throws -> [Plant] {
        let encodedSearch = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: "https://trefle.io/api/v1/plants/search?token=QQPtbDapaVxF_AD3qkee1xtRUVMNLNRCs2tGtR4x4YI&q=\(encodedSearch)") else {
            throw HTTPError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        do{
            let results = try JSONDecoder().decode([Plant].self, from: data)
            self.recipe = recipe
        } catch {
            throw error
        }
    }
}
*/
import Foundation

class PlantRepository {
    enum HTTPError: Error {
        case invalidURL
        case invalidResponse
    }
    
    
    
    static func loadPlants(search: String) async throws -> [Plant] {
        let encodedSearch = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        guard let url = URL(string: "https://trefle.io/api/v1/plants/search?token=QQPtbDapaVxF_AD3qkee1xtRUVMNLNRCs2tGtR4x4YI&q=\(encodedSearch)") else {
            throw HTTPError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw HTTPError.invalidResponse
            }
            
            struct Response: Decodable {
                let data: [Plant]
            }
            
            do {
                let decodedData = try JSONDecoder().decode(Response.self, from: data)
                return decodedData.data
            } catch let decodingError as DecodingError {
                print("Decoding error:", decodingError)
                throw decodingError
            } catch {
                print("Error decoding data: \(error)")
                throw error
            }
        } catch {
            print("Error fetching data: \(error)")
            throw error
        }
    }
  }
    /*
    func savePlantsToCoreData(plants: [Plant]) {
            let context = persistentStore.context

            for plantData in plants {
                let newPlant = PlantCD(context: context)

                newPlant.favorite = false 
                newPlant.id = UUID()
                newPlant.name = plantData.common_name ?? ""
                
                // Bild als Binärdaten speichern (UIImage -> Data)
                if let imageUrl = plantData.image_url, let imageData = try? Data(contentsOf: URL(string: imageUrl.absoluteString)!) {
                    newPlant.img = imageData
                }

                do {
                    try context.save()
                } catch {
                    print("Fehler beim Speichern der Pflanzendaten in Core Data: \(error)")
                }
            }
        }
}*/

