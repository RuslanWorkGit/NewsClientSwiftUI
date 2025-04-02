//
//  SavedNewsListView.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 25.03.2025.
//

import SwiftUI

struct SavedNewsListView: View {
    
    @StateObject var viewModel: SavedNewsListViewModel
    
    var body: some View {
            SavedNewsList(savedArticles: viewModel.savedFavoriteNews)
            .onAppear {
                viewModel.fetchSavedFavoriteNews()
            }
            .navigationTitle("Saved news")
    }
}


