//
//  PlantCDEditView.swift
//  Woods-JWA
import SwiftUI
import PhotosUI

struct PlantCDEditView: View {
    @ObservedObject var viewModel: PlantCDViewModel
    @Binding var isEditMode: Bool
    @State private var showCameraView = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("editMode:")
                        .padding(.top, 10)
                        .font(.headline)
                    VStack(alignment: .leading) {
                        Text("name")
                            .font(.headline)
                        TextField("name", text: $viewModel.common_name)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        
                        Text("age (year):")
                            .font(.headline)
                        TextField("age", text: $viewModel.age)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("height (m):")
                            .font(.headline)
                        TextField("maxHeight", text: $viewModel.height)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("specials:")
                            .font(.headline)
                        TextEditor(text: $viewModel.specialSkill)
                            .padding()
                            .frame(height: 150)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 2))
                        Text("other Informations")
                            .font(.headline)
                        
                        TextEditor(text: $viewModel.details)
                            .padding()
                            .frame(height: 150)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 2))
                    }
                    
                    Picker("choose", selection: $viewModel.selectedImageType) {
                        Text("Pic 1").tag(ImageType.imgCD)
                        Text("Pic 2").tag(ImageType.imgCD2)
                        Text("Pic 3").tag(ImageType.imgCD3)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    HStack {
                        VStack {
                            if let image = viewModel.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 80)
                            } else {
                                Text("no pic")
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer() // Fügt einen Leerraum ein, um die Zahlen zu zentrieren
                            Text("Pic1")
                                .foregroundColor(.black)
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                        }
                        
                        VStack {
                            if let image2 = viewModel.image2 {
                                Image(uiImage: image2)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 80)
                            } else {
                                Text("no pic")
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            Text("Pic2")
                                .foregroundColor(.black)
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                        }
                        
                        VStack {
                            if let image4 = viewModel.image4 {
                                Image(uiImage: image4)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 80)
                            } else {
                                Text("no pic")
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            Text("Pic3")
                                .foregroundColor(.black)
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding()
                    
                    if let previewImage = viewModel.selectedImageData, let image = UIImage(data: previewImage) {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                    } else {
                        Text("no preview avaible")
                            .foregroundColor(.gray)
                    }
                    
                    Button("via livePic") {
                        showCameraView.toggle()
                    }
                    .padding()
                    .sheet(isPresented: $showCameraView) {
                        TSCameraView(image: $selectedImage, viewModel: viewModel)
                        
                    }
                    /*
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                    } else if let selectedImageData = viewModel.selectedImageData, let uiImage = UIImage(data: selectedImageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                    }*/
                    
                    PhotosPicker(selection: $viewModel.selectedImage, matching: .images, photoLibrary: .shared()) {
                        Text("choose photo")
                    }
                    
                    .onChange(of: viewModel.selectedImage) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                DispatchQueue.main.async {
                                    print("Selected Image Data: \(data)")
                                    viewModel.selectedImageData = data
                                }
                            }
                        }
                    }
                    
                    Section {
                        VStack(spacing: 20) {
                            SaveChanges(viewModel: viewModel, isEditMode: $isEditMode)
                            
                        }
                        .padding(.bottom, 16)
                    }
                }
            }
            .padding([.leading, .trailing], 16)
        }
    }
}


struct PlantCDEditView_Previews: PreviewProvider {
    static var previews: some View {
        PlantCDEditView(viewModel: PlantCDViewModel(plantcd: PlantCD()), isEditMode: .constant(true))
    }
}
