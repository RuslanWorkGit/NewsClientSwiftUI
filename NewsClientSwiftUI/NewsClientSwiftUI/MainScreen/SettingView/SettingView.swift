//
//  SettingView.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 14.03.2025.
//

import SwiftUI

struct SettingView: View {
    
    @Environment(\.modelContext) private var context
    @StateObject var viewModel: SettingViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: SavedNewsListView(viewModel: SavedNewsListViewModel(context: context))) {
                    Text("Show Saved News")
                        .standartButtonStyle()
                                    
                }
                
                Button {
                    viewModel.cleaneCache()
                } label: {
                    Text("Clean cache")
                        .standartButtonStyle()
                }

            }
            .navigationTitle("Setting")
            
        }
        
    }
}

struct StandartButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .padding(.horizontal)
    }
}

extension View {
    func standartButtonStyle() -> some View {
        self.modifier(StandartButtonModifier())
    }
}
