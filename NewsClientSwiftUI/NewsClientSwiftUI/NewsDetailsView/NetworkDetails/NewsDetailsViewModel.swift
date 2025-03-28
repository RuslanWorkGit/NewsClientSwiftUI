//
//  NewsDetailsViewModel.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 17.03.2025.
//

import Foundation
import SwiftData

@MainActor
class NewsDetailsViewModel: ObservableObject {
    
    private var swiftDataService = SwiftDataService.shared
    let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func saveToSD(article: Articles) {
        
        guard let imageUrlString = article.urlToImage,
              let imageUrl = URL(string: imageUrlString) else { return }
        
        let task = URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            
            if let responseError = error {
                print(responseError)
            }
            
            guard let responseData = data else { return }
            
            let articleToSave = SDNewsModel(title: article.title,
                                            author: article.author ?? "",
                                            name: article.source.name,
                                            descriptionLabel: article.description ?? "",
                                            content: article.content ?? "",
                                            publishedAt: article.publishedAt,
                                            url: article.url,
                                            image: responseData,
                                            category: "Search")
            
            articleToSave.isFavorite = true
            
            self.swiftDataService.addArticle(article: articleToSave, modelContext: self.context)
            
            do {
                try self.context.save()
                print("News Saved to favorites")
            } catch {
                print("error save news")
            }
        }
        
        task.resume()
        
        
    }
    
    func deleteFromSD(article: Articles) {
        
        let news = swiftDataService.fetchArticleUrl(with: article.url, context: context)
        
        guard let newsToDelete = news else { return }
        
        if newsToDelete.isFavorite {
            newsToDelete.isFavorite = false
            
            context.delete(newsToDelete)
            
            do {
                try context.save()
                print("News deleted")
            } catch {
                print("error delete news from favoriete")
            }
        }
        
    }
    
    func checkIsSavedInSD(article: Articles) -> Bool {
        let news = swiftDataService.fetchArticleUrl(with: article.url, context: context)
        
        guard let savedNews = news else { return false }
        print(savedNews.isFavorite)
        return savedNews.isFavorite
    }
    

    
}
