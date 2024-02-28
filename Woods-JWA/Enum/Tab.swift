//
//  Tab.swift
//  Woods-JWA
//
//  Created by Johannes Ahlborn on 10.01.24.
//

import SwiftUI

enum Tab: String, Identifiable, CaseIterable {
    case globalSearch, favoriteView, personalLexicon
    
    var id: String {rawValue}
    
    var title: String {
        switch self {
        case .globalSearch: return "global plant search"
        case .favoriteView: return "favorite overview"
        case .personalLexicon: return "personal Lexicon"
        }
    
    }
    
    var icon: String {
        switch self {
        case .globalSearch: return "globe.europe.africa.fill"
        case .favoriteView: return "tree.fill"
        case .personalLexicon: return "character.book.closed.fill"
        }
    }
    
    var view: AnyView {
        switch self {
        case .globalSearch: return AnyView(PlantSearchView())
        case .favoriteView: return AnyView(PlantFavoriteView(viewModel: PlantViewModel()))
        case .personalLexicon: return AnyView(PlantCDListView())
        }
    }
}

