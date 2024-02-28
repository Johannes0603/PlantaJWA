//
//  DeleteBtn.swift
//  Woods-JWA
//
//  Created by Johannes Ahlborn on 02.02.24.
//



import SwiftUI

struct DeleteButton: View {
    
    @State private var isDeleteConfirmationAlertPresented = false
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            isDeleteConfirmationAlertPresented.toggle()
        }) {
            ZStack {
                Circle()
                    .foregroundColor(Color.white.opacity(0.4))
                    .frame(width: 40)
                
                Image(systemName: "trash.fill")
                    .font(.headline)
                    .foregroundColor(.red)
            }
        }
        .alert(isPresented: $isDeleteConfirmationAlertPresented) {
            Alert(
                title: Text("Löschen bestätigen"),
                message: Text("Sind Sie sicher, dass Sie diese Pflanze löschen möchten?"),
                primaryButton: .destructive(Text("Löschen")) {
                    action()
                  
                    
                },
                secondaryButton: .cancel()
            )
        }
    }
}

struct DeleteButton_Previews: PreviewProvider {
    static var previews: some View {
        DeleteButton { }
    }
}

