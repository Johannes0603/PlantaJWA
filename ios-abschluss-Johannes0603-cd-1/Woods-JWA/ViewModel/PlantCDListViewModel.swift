//
//  PlantCDListViewModel.swift
//  Woods-JWA
//
//  Created by Johannes Ahlborn on 20.01.24.
//
import Foundation
import CoreData
import Combine

class PlantCDListViewModel: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var CDViewModels = [PlantCDViewModel]()
    @Published var searchText = ""
    
    private let container = PersistentStore.shared
    
    init() {
        setupObservers()
        fetchCDPlants()
    }
    
    private func setupObservers() {
        let didSaveNotification = NSManagedObjectContext.didSaveObjectsNotification
        NotificationCenter.default.publisher(for: didSaveNotification)
            .sink { [weak self] _ in
                self?.fetchCDPlants()
            }
            .store(in: &cancellables)
    }

    func fetchCDPlants() {
        let request = NSFetchRequest<PlantCD>(entityName: "PlantCD")
        request.sortDescriptors = [NSSortDescriptor(key: "common_name", ascending: true)]
        
        do {
            let plants = try container.context.fetch(request)
            CDViewModels = plants.map(PlantCDViewModel.init)
        } catch {
            print("Fehler beim Laden der Pflanzen: \(error.localizedDescription)")
        }
    }
    
    func filterCDPlants() -> [PlantCDViewModel] {
        guard !searchText.isEmpty else {
            return CDViewModels
        }
        return CDViewModels.filter { $0.common_name.lowercased().contains(searchText.lowercased()) }
    }
}
