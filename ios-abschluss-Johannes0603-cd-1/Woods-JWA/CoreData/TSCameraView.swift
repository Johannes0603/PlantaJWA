//
//  TSCameraView.swift
//  Woods-JWA
//
//  Created by Johannes Ahlborn on 29.01.24.
//

import SwiftUI
import UniformTypeIdentifiers

struct TSCameraView: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    let viewModel: PlantCDViewModel

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: TSCameraView

        init(parent: TSCameraView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
                parent.viewModel.updateSelectedImageData(with: uiImage, for: parent.viewModel.selectedImageType)
                
               
                if let data = uiImage.jpegData(compressionQuality: 0.8) {
                    parent.viewModel.selectedImageData = data
                }
            }
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }

       func makeCoordinator() -> Coordinator {
           Coordinator(parent: self)
       }

       func makeUIViewController(context: Context) -> UIImagePickerController {
           let imagePickerController = UIImagePickerController()
           imagePickerController.mediaTypes = [UTType.image.identifier]
           imagePickerController.sourceType = .camera
           imagePickerController.delegate = context.coordinator
           return imagePickerController
       }

       func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
   }
//MARK:  Quelle: https://letscode.thomassillmann.de/kamerazugriff-via-swiftui/
