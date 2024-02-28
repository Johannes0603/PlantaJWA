

import Foundation
import SwiftUI
import PhotosUI
import Photos

class PlantCDViewModel: ObservableObject {
    
    let idCD: UUID
    var plantcd: PlantCD
    @Published var image: UIImage?
    @Published var image2: UIImage?
    @Published var image3: UIImage?
    @Published var image4: UIImage?
    @Published var selectedImageIndex: Int = 0 {
        didSet {
            loadImageAtIndex()
        }
    }
    @Published var common_name = ""
    @Published var details = ""
    @Published var scientific_name = ""
    @Published var age = ""
    @Published var height = ""
    @Published var specialSkill = ""
    @Published var imgCD: Data?
    @Published var imgCD2: Data?
    @Published var imgCD3: Data?
    @Published var selectedImage: PhotosPickerItem?
    @Published var selectedImageType: ImageType = .imgCD
    @Published var selectedImageData: Data?
    @Published var isSheetPresented = false
    @Published var previousImageType: ImageType?
    @Published var previousImageData: Data?
    @Published var isDeleteConfirmationAlertPresented = false
    @Published var isLoadingImages = false
    private let container = PersistentStore.shared
    
    init(plantcd: PlantCD) {
        self.idCD = plantcd.idCD ?? UUID()
        self.plantcd = plantcd
        self.common_name = plantcd.common_name ?? ""
        self.details = plantcd.details ?? ""
        self.age = plantcd.age ?? ""
        self.height = plantcd.height ?? ""
        self.specialSkill = plantcd.specialSkill ?? ""
        
        if let imgCDData = plantcd.imgCD {
            self.image = UIImage(data: imgCDData)
        } else {
            self.image = nil
        }
        
        if let imgCD2Data = plantcd.imgCD2 {
            self.image2 = UIImage(data: imgCD2Data)
        } else {
            self.image2 = nil
        }
        if let imgCD3Data = plantcd.imgCD3 {
            self.image4 = UIImage(data: imgCD3Data)
        } else {
            self.image4 = nil
        }
        if let imageUrl = plantcd.image_url {
            isLoadingImages = true
            loadImageFromURL(url: imageUrl)
        } else {
            self.image3 = nil
        }
    }
    
    private func loadImageFromURL(url: URL) {
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                self.image3 = UIImage(data: data)
                self.isLoadingImages = false // Bild wurde geladen
            } catch {
                print("Fehler beim Laden des Bildes von der URL: \(error)")
                self.image3 = nil
                self.isLoadingImages = false // Fehler beim Laden
            }
        }
    }
    
 
    
    var displayedImage: UIImage? {
        switch selectedImageType {
        case .imgCD:
            return UIImage(data: imgCD ?? Data())
        case .imgCD2:
            return UIImage(data: imgCD2 ?? Data())
        case .imgCD3:
            return UIImage(data: imgCD3 ?? Data())
        }
    }
    
    
    func reloadPlantCD() {
        guard let reloadedPlantCD = container.context.object(with: plantcd.objectID) as? PlantCD else {
            return
        }

        DispatchQueue.main.async {
            self.plantcd = reloadedPlantCD
            self.common_name = reloadedPlantCD.common_name ?? ""
            self.details = reloadedPlantCD.details ?? ""
            self.age = reloadedPlantCD.age ?? ""
            self.height = reloadedPlantCD.height ?? ""
            self.specialSkill = reloadedPlantCD.specialSkill ?? ""
            self.image = UIImage(data: reloadedPlantCD.imgCD ?? Data())
            self.image2 = UIImage(data: reloadedPlantCD.imgCD2 ?? Data())
            self.image4 = UIImage(data: reloadedPlantCD.imgCD3 ?? Data())
            
            if let imageUrl = reloadedPlantCD.image_url {
                self.isLoadingImages = true
                self.loadImageFromURL(url: imageUrl)
            } else {
                self.image3 = nil
            }
        }
    }
    
    func saveChanges() {
      reloadPlantCD()
        
        print("Saving Changes - Image Data: \(selectedImageData)")
        
        plantcd.common_name = common_name
        plantcd.details = details
        plantcd.age = age
        plantcd.height = height
        plantcd.specialSkill = specialSkill
        
        switch selectedImageType {
           case .imgCD:
               if let imageData = selectedImageData {
                   plantcd.imgCD = imageData
               }
           case .imgCD2:
               if let imageData = selectedImageData {
                   plantcd.imgCD2 = imageData
               }
           case .imgCD3:
               if let imageData = selectedImageData {
                   plantcd.imgCD3 = imageData
               }
           }
        container.save()
        
    }
    
    var disableButton: Bool {
        common_name.isEmpty || details.isEmpty
    }
    
    func changeImageType(_ newType: ImageType) {
        selectedImageType = newType
    }
    
    func delete() {
        container.context.delete(plantcd)
        container.save()
        isDeleteConfirmationAlertPresented = false
    }
    
    internal func loadImageAtIndex() {
        switch selectedImageIndex {
        case 0:
            loadImageFromData(data: imgCD)
            updatePreviousImage(item: imgCD, imageType: .imgCD)
        case 1:
            loadImageFromData(data: imgCD2)
            updatePreviousImage(item: imgCD2, imageType: .imgCD2)
        case 2:
            if let imageUrl = plantcd.image_url {
                loadImageFromURL(url: imageUrl)
            }
        case 3:
            loadImageFromData(data: imgCD3)
            updatePreviousImage(item: imgCD3, imageType: .imgCD3)
        default:
            break
        }
    }
    
    private func loadImageFromData(data: Data?) {
        if let imageData = data {
            self.image = UIImage(data: imageData)
        }
    }

    private func updatePreviousImage(item: Data?, imageType: ImageType?) {
        self.previousImageData = item
        self.previousImageType = imageType
    }
    
    func hasChanges() -> Bool {
        return common_name != plantcd.common_name || age != plantcd.age || height != plantcd.height || specialSkill != plantcd.specialSkill || details != plantcd.details || selectedImageData != nil || selectedImage != nil
      }
    
    func updateSelectedImageData(with image: UIImage, for imageType: ImageType) {
        switch imageType {
        case .imgCD:
            imgCD = image.jpegData(compressionQuality: 0.8)
        case .imgCD2:
            imgCD2 = image.jpegData(compressionQuality: 0.8)
        case .imgCD3:
            imgCD3 = image.jpegData(compressionQuality: 0.8)
        }
    }
}
