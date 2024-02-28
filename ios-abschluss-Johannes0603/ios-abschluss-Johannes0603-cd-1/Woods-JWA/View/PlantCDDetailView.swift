//
//  PlantCDView.swift
//  Woods-JWA
//
//  Created by Johannes Ahlborn on 20.01.24.
//



import SwiftUI
import PhotosUI
import CoreData

struct PlantCDDetailView: View {
    @ObservedObject var viewModel: PlantCDViewModel
    @State private var isEditMode = false
    @Environment(\.presentationMode) var presentationMode
    @State private var enlargedImage: ImageWrapper?
    
    
    
    
    
    var body: some View {
        ScrollView {
            VStack {
                Text(viewModel.common_name)
                    .font(.headline)
                    .padding(.bottom, 10)
                
                if viewModel.isLoadingImages {
                    ProgressView()
                        .frame(width: 200, height: 100)
                        .padding(.bottom, 10)
                } else if let image = viewModel.image {
                    Button(action: {
                        enlargedImage = ImageWrapper(image: image)
                    }) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 100)
                            .cornerRadius(10)
                            .padding(.bottom, 10)
                    }
                    .sheet(item: $enlargedImage) { imageWrapper in
                        EnlargedImageView(image: imageWrapper.image)
                    }
                }
                
                if viewModel.isLoadingImages {
                    ProgressView()
                        .frame(width: 200, height: 100)
                        .padding(.bottom, 10)
                } else if let image2 = viewModel.image2 {
                    Button(action: {
                        enlargedImage = ImageWrapper(image: image2)
                    }) {
                        Image(uiImage: image2)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 100)
                            .cornerRadius(10)
                            .padding(.bottom, 10)
                    }
                    .sheet(item: $enlargedImage) { imageWrapper in
                        EnlargedImageView(image: imageWrapper.image)
                    }
                }
                
                if viewModel.isLoadingImages {
                    ProgressView()
                        .frame(width: 200, height: 100)
                        .padding(.bottom, 10)
                } else if let image3 = viewModel.image3 {
                    Button(action: {
                        enlargedImage = ImageWrapper(image: image3)
                    }) {
                        Image(uiImage: image3)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 100)
                            .cornerRadius(10)
                            .padding(.bottom, 10)
                    }
                    .sheet(item: $enlargedImage) { imageWrapper in
                        EnlargedImageView(image: imageWrapper.image)
                    }
                }
                
                if viewModel.isLoadingImages {
                    ProgressView()
                        .frame(width: 200, height: 100)
                        .padding(.bottom, 10)
                } else if let image4 = viewModel.image4 {
                    Button(action: {
                        enlargedImage = ImageWrapper(image: image4)
                    }) {
                        Image(uiImage: image4)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 100)
                            .cornerRadius(10)
                            .padding(.bottom, 10)
                    }
                    .sheet(item: $enlargedImage) { imageWrapper in
                        EnlargedImageView(image: imageWrapper.image)
                    }
                }
            
                
                HStack {
                    Text("age:")
                        .font(.headline)
                        .padding(.bottom, 5)
                    Text("\(viewModel.age) years")
                        .padding(.bottom, 5)
                        .font(.headline)
                }
                HStack {
                    Text("maxHeight:")
                        .font(.headline)
                        .padding(.bottom, 5)
                    Text("\(viewModel.height) m")
                        .padding(.bottom, 5)
                        .font(.headline)
                }
                
                    Text("special:")
                        .font(.headline)
                        .padding(.bottom, 5)
                    Text("\(viewModel.specialSkill)")
                        .padding(.bottom, 5)
                       
                
              
                Text("other informations:")
                    .font(.headline)
                    .padding(.bottom, 20)
                Text(viewModel.details)
                    .padding(.bottom, 20)
                    .navigationTitle("plant-details")
                    .sheet(isPresented: $isEditMode) {
                        PlantCDEditView(viewModel: viewModel, isEditMode: $isEditMode)
                    }
           
                
                DeleteButton {
                     viewModel.delete()
                     presentationMode.wrappedValue.dismiss()
                 }
                 .toolbar {
                     Button {
                         isEditMode.toggle()
                     } label: {
                         Image(systemName: "pencil")
                             .frame(width: 40, height: 40)
                             .background(Circle().fill(Color.white))
                             .foregroundColor(.blue)
                     }
                 }
            }
            .padding()
        }
        .background(Image("Backg_details"))
    }
    private func reloadImages() {
        viewModel.isLoadingImages = true
        viewModel.reloadPlantCD() 
        viewModel.isLoadingImages = false
    }
}

class ImageWrapper: Identifiable {
    let id = UUID()
    let image: UIImage

    init(image: UIImage) {
        self.image = image
    }
}

struct PlantCDDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlantCDDetailView(viewModel: PlantCDViewModel(plantcd: PlantCD(context: PersistentStore.shared.context)))
    }
}

