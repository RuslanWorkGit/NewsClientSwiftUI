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
    
    func dowloadImage(from imageStringUrl: String, completion: @escaping ((Data?) -> Void)) {
        
        guard let url = URL(string: imageStringUrl) else {
            print("Wrong link!")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let responseError = error {
                print("Error: \(responseError)")
                completion(nil)
            }
            
            completion(data)
        }
        
        task.resume()
    }
    
    func saveToSD(article: NewsDetailsDisplay) {
        var imageData: Data?
        
        guard let urlImageString = article.imageDetails else {
            return
        }
        
        dowloadImage(from: urlImageString) { data in
            imageData = data
        }
        
        let newsToSave = SDNewsModel(title: article.titleDetails,
                                     author: article.authorDetails,
                                     name: article.nameDetails,
                                     descriptionLabel: article.descriptionDetails,
                                     content: article.contentDetails,
                                     publishedAt: article.publishedAtDetailsc,
                                     url: article.urlDetails,
                                     image: imageData,
                                     category: "Search",
                                     isFavorite: true)
                
        print(newsToSave.url)
        //print(newsToSave.urlDetails)
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
        print("\(newsToDelete.url) + \(newsToDelete.isFavorite)")
        
        if newsToDelete.isFavorite {
            
            print(newsToDelete.isFavorite)
            newsToDelete.isFavorite = false
            
            context.delete(newsToDelete)
            print("News delete")
            
            do {
                try context.save()
            } catch {
                print("Error delete")
            }
        } else {
            print("News not found")
        }
    }
    
    func checkIsSavedInSD(article: NewsDetailsDisplay) -> Bool {
        let news = swiftDataService.fetchArticleUrl(with: article.urlDetails, context: context)
        
        guard let savedNews = news else { return false }
        print("FAVORITE:   \(savedNews.isFavorite)")
        return savedNews.isFavorite
    }
}
