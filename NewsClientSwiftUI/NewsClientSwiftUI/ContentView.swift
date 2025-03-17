//
//  ContentView.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 13.03.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                MainView()
            }
            .badge(2)
            
            Tab("Search", systemImage: "magnifyingglass") {
                SearchView()
            }
            
            
            Tab("Setting", systemImage: "gear") {
                SettingView()
            }
            
            
        }
    }
}

#Preview {
    ContentView()
}
