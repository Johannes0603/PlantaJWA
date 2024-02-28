//
//  SearchBar.swift
//  Woods-JWA
//
//  Created by Johannes Ahlborn on 04.02.24.
//

import Foundation
import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("filter", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 10)
        }
        .padding(.vertical, 10)
    }
}
