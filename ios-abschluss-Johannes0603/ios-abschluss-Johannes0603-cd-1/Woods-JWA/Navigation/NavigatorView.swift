//
//  NavigationView.swift
//  Woods-JWA
//
//  Created by Johannes Ahlborn on 10.01.24.
//

import SwiftUI

struct NavigatorView: View {
    var body: some View {
        TabView {
            Group {
                ForEach(Tab.allCases) { tab in
                    tab.view
                        .tabItem {
                            Label(tab.title, systemImage: tab.icon)
                                .font(.headline)
                        }
                        .tag(tab)
                }
            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color.green.opacity(0.1), for: .tabBar)
        }
    }
}


struct NavigatorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigatorView()
    }
}
