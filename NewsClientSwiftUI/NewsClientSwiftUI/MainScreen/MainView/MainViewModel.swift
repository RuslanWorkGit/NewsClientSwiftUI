//
//  MainViewModel.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 14.03.2025.
//

import Foundation
import SDWebImage
import SwiftData

@MainActor
class MainViewModel: ObservableObject {
    
    private let networkService: NetworkServiceProtocol
    private let apiLink = ApiLink()
    private let swiftDataService = SwiftDataService.shared
    
    @Published var savedNews: [SDNewsModel] = []
    @Published var newsRequest: NewsRequest?
    let context: ModelContext
    
    init(networkService: NetworkServiceProtocol = NetworkService(), context: ModelContext) {
        self.context = context
        self.networkService = networkService
    }
    
    func fetch(category: Category) {
        guard let url = apiLink.bildUrl(endpoints: .topHeadLines, category: category) else {
            print("wrong link")
            return
        }
        
        networkService.fetch(with: url) { [self] (result: Result<NewsRequest, Error>) in
            switch result {
            case .success(let success):
                self.newsRequest = success
                
                let group = DispatchGroup()
                for article in success.articles {
                    group.enter()
                    addToSD(article: article, category: category.rawValue) {
                        group.leave()
                    }
                }
                
                group.notify(queue: .main) {
                    do {
                        try self.context.save()
                    } catch {
                        print("Error save")
                    }
                    
                    self.savedNews = self.swiftDataService.fetchArticle(categorys: category.rawValue, modelContext: self.context)
                    print(self.savedNews.count)
                }
                
                
                
                
            case .failure(let failure):
                print("Error: \(failure)")
            }
        }
    }
    
    func addToSD(article: Articles, category: String, completion: @escaping () -> Void) {
        
                
        if swiftDataService.existsArticle(with: article.url, modelContext: context) {
            print("News already exists")
            completion()
            return
        }
        
        guard let imageUrlString = article.urlToImage, let imageURL = URL(string: imageUrlString)else {
            print("Wrong link")
            completion()
            return
        }
        
        let task = URLSession.shared.dataTask(with: imageURL) { data, response, error in
            
            defer { completion() }
            if let responseError = error {
                print("Error loading image: \(responseError)")
                return
            }
            
            guard let responseData = data, let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                print("Image download failed with sttus code: \(statusCode)")
                return
            }
            
            let newArticle = SDNewsModel(title: article.title,
                                         author: article.author ?? "",
                                         name: article.source.name ,
                                         descriptionLabel: article.description ?? "",
                                         content: article.content ?? "",
                                         publishedAt: article.publishedAt,
                                         url: article.url,
                                         image: responseData,
                                         category: category)
            
            DispatchQueue.main.async {
                self.swiftDataService.addArticle(article: newArticle, modelContext: self.context)
            }
        }
        
        task.resume()
  
    }

}
