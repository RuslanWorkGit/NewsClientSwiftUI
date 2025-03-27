//
//  NewsDetailsGenericViewModel.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 27.03.2025.
//

import Foundation
import SwiftData

@MainActor
class NewsDetailsGenericViewModel: ObservableObject {
    
    private var swiftDataService = SwiftDataService.shared
    
    let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func saveToSD(article: NewsDetailsDisplay) {
        
        let newsToSave = SDNewsModel(title: article.titleDetails,
                                     author: article.authorDetails,
                                     name: article.nameDetails,
                                     descriptionLabel: article.descriptionDetails,
                                     content: article.contentDetails,
                                     publishedAt: article.publishedAtDetailsc,
                                     url: article.urlDetails,
                                     image: article.imageDetails,
                                     category: "Search")
        newsToSave.isFavorite = true
        
        swiftDataService.addArticle(article: newsToSave, modelContext: context)
        
        do {
            try context.save()
        } catch {
            print("Error to save")
        }
    }
    
    func deleteFromSD(article: NewsDetailsDisplay) {
        let news = swiftDataService.fetchArticleUrl(with: article.urlDetails, context: context)
        
        guard let newsToDelete = news else { return }
        
        if newsToDelete.isFavorite {
            newsToDelete.isFavorite = false
            
            context.delete(newsToDelete)
            
            do {
                try context.save()
            } catch {
                print("Error delete")
            }
        }
    }
    
    func checkIsSavedInSD(article: NewsDetailsDisplay) -> Bool {
        let news = swiftDataService.fetchArticleUrl(with: article.urlDetails, context: context)
        
        guard let savedNews = news else { return false }
        
        return savedNews.isFavorite
    }
}
