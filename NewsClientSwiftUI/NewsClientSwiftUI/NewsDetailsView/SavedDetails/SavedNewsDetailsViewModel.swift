//
//  SavedNewsDetailsViewModel.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 25.03.2025.
//

import Foundation
import SwiftData

@MainActor
class SavedNewsDetailsViewModel: ObservableObject {
    
    private var swiftDataService = SwiftDataService.shared
    let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func save(article: SDNewsModel) {
        
        let news = swiftDataService.fetchArticleUrl(with: article.url, context: context)
        
        guard let savedNews = news else { return }
        
        if savedNews.isFavorite {
            print("News alredy saved")
        } else {
            savedNews.isFavorite = true
            do {
                try context.save()
                print("News saved")
            } catch {
                print("Error saving news: \(error)")
            }
            
        }
    }
    
    func delete(article: SDNewsModel) {
        let news = swiftDataService.fetchArticleUrl(with: article.url, context: context)
        
        guard let newsToDelete = news else { return }
        
        if newsToDelete.isFavorite {
            newsToDelete.isFavorite = false
            
            context.delete(newsToDelete)
            
            do {
                print("News delete")
                try context.save()
            } catch {
                print("Error delete news")
            }
        }
    }
    
    func chechIfSaved(article: SDNewsModel) -> Bool {
        
        let news = swiftDataService.fetchArticleUrl(with: article.url, context: context)
        
        guard let savedNews = news else { return false }
        return savedNews.isFavorite
    }
}
