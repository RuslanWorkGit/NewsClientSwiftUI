//
//  SavedNewsListViewModel.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 25.03.2025.
//

import Foundation
import SwiftData

@MainActor
class SavedNewsListViewModel: ObservableObject {
    
    @Published var savedFavoriteNews: [SDNewsModel] = []
    
    let context: ModelContext
    private let swiftDataService = SwiftDataService.shared
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func fetchSavedFavoriteNews() {
        let result = swiftDataService.fetchFavoritesNews(isFavorite: true, modelContext: context)
        
        savedFavoriteNews = result
    }
}
