//
//  MainViewModel.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 14.03.2025.
//

import Foundation
import SDWebImageSwiftUI

@MainActor
class MainViewModel: ObservableObject {
    
    private let networkService: NetworkServiceProtocol
    private let apiLink = ApiLink()
    
    @Published var savedNews: [SDNewsModel] = []
    @Published var newsRequest: NewsRequest?
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetch(category: Category) {
        guard let url = apiLink.bildUrl(endpoints: .topHeadLines, category: category) else {
            print("wrong link")
            return
        }
        
        networkService.fetch(with: url) { (result: Result<NewsRequest, Error>) in
            switch result {
            case .success(let success):
                self.newsRequest = success
                for article in success.articles {
                    Task {
                        await self.addNewsToSD(article: article, category: category)
                    }
                }
                self.savedNews = SwiftDataService.shared.fetchArticle(category: category.rawValue)
            case .failure(let failure):
                print("Error: \(failure)")
            }
        }
    }
    
//    func getArticles(article: Articles) {
//        
//        
//        let result = SwiftDataService.shared.fetchAllArticles(url: article.url)
//        if let news = result {
//            savedNews.append(news)
//        } else {
//            print("Nil")
//        }
//        
//    }
    
    func addNewsToSD(article: Articles, category: Category) async {
        
        if SwiftDataService.shared.existsArticle(with: article.url) {
            print("News already exists")
            return
        }
        
        guard let imageURL = URL(string: article.urlToImage ?? "") else {
            print("Invalid image url")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: imageURL)
            
            let newNews = SDNewsModel(title: article.title,
                                      author: article.author ?? "",
                                      name: article.source.name,
                                      descriptionLabel: article.description ?? "",
                                      content: article.content ?? "",
                                      publishedAt: article.publishedAt,
                                      url: article.url,
                                      image: data,
                                      category: category.rawValue)
            
            SwiftDataService.shared.addArticle(article: newNews)
        } catch {
            print("Error load image: \(error)")
        }
  
    }
}
