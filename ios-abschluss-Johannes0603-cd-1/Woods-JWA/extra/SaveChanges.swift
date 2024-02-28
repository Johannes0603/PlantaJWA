//
//  SaveChanges.swift
//  Woods-JWA
//
//  Created by Johannes Ahlborn on 07.02.24.
//

import Foundation
import SwiftUI
import CoreData

struct SaveChanges: View {
    @ObservedObject var viewModel: PlantCDViewModel
    @Binding var isEditMode: Bool
    @State private var showAlert = false
    
    var body: some View {
        VStack(spacing: 10) {
            Button(action: {
                if viewModel.hasChanges() {
                    showAlert = true
                }
            }) {
                Text("Änderungen speichern")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.8))
                    .cornerRadius(8)
                    .foregroundColor(.white)
            }
            
            Button(action: {
                isEditMode.toggle()
            }) {
                Text("Abbrechen")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red.opacity(0.8))
                    .cornerRadius(8)
                    .foregroundColor(.white)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Änderungen speichern"),
                message: Text("Möchten Sie die aktuelle Datei wirklich überschreiben?"),
                primaryButton: .default(Text("Speichern")) {
                    saveChanges()
                },
                secondaryButton: .destructive(Text("cancel"))
                
            )
        }
    }
    
    private func saveChanges() {
        DispatchQueue.main.async {
            viewModel.saveChanges()
            isEditMode.toggle()
        }
    }
}
