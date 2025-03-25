//
//  ContentView.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 13.03.2025.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.modelContext) private var context
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                //MainView(viewModel: MainViewModel(context: context))
                MainView(viewModel: MainViewModel(context: context))
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
