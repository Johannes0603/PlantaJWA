//
//  EnlargedImageView.swift
//  Woods-JWA
//
//  Created by Johannes Ahlborn on 19.02.24.
//

import SwiftUI

struct EnlargedImageView: View, Identifiable {
    let id = UUID()
    let image: UIImage

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .cornerRadius(10)
            .navigationBarTitle("Enlarged Image", displayMode: .inline)
    }
}
