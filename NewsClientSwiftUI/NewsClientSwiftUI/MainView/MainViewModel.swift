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
                
                
//                for article in success.articles {
//                    if let oneNews = swiftDataService.fetchArticleUrl(with: article.url, context: context){
//                        savedNews.append(oneNews)
//                    }
//                        
//                }
                
                
                
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
    
//    func fetchAsync(category: Category) async {
//        guard let url = apiLink.bildUrl(endpoints: .topHeadLines, category: category) else {
//            print("wrong link")
//            return
//        }
//        
//        do {
//            let result: NewsRequest = try await networkService.fetchAsync(with: url)
//            
//            for article in result.articles {
//                await self.addNewsToSD(article: article, category: category)
//            }
//            
//            do {
//                try context.save()
//            } catch {
//                print("Помилка збереження контексту: \(error)")
//            }
//            
//            self.savedNews = swiftDataService.fetchArticle(categorys: category.rawValue, modelContext: context)
//            print("Saved News Count: \(self.savedNews.count)")
//        } catch {
//            print("Error fetch")
//        }
//    }
    
//    func fetchArticle(url: String){
////        self.savedNews = swiftDataService.fetchArticle(categorys: category, modelContext: context)
//        
//        if let findNews = swiftDataService.fetchArticleUrl(with: url, context: context) {
//            self.savedNews.append(findNews)
//            print(savedNews.count)
//        } else {
//            print(savedNews.count)
//        }
//        
//    }
    
//    func addNewsToSD(article: Articles, category: Category) {
//        
//        if swiftDataService.existsArticle(with: article.url, modelContext: context) {
//            print("News already exists")
//            return
//        }
//        
//        guard let imageUrlString = article.urlToImage, let imageURL = URL(string: imageUrlString) else {
//            print("Invalid image url")
//            return
//        }
        
//        do {
//            let (data, response) = URLSession.shared.data(from: imageURL)
//            
//            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
//                print("Image download failed with status code: \(httpResponse.statusCode)")
//                return
//            }
//            
//            let newNews = SDNewsModel(title: article.title,
//                                      author: article.author ?? "",
//                                      name: article.source.name,
//                                      descriptionLabel: article.description ?? "",
//                                      content: article.content ?? "",
//                                      publishedAt: article.publishedAt,
//                                      url: article.url,
//                                      image: data,
//                                      category: category.rawValue)
//            
//            print("\(newNews.title)")
//            
//            swiftDataService.addArticle(article: newNews, modelContext: context )
//        } catch {
//            print("Error load image: \(error)")
//        }
        
        // Створюємо завдання для завантаження даних зображення
//            let task = URLSession.shared.dataTask(with: imageURL) { data, response, error in
//                if let error = error {
//                    print("Error load image: \(error)")
//                    return
//                }
//                
//                guard let data = data,
//                      let httpResponse = response as? HTTPURLResponse,
//                      (200...299).contains(httpResponse.statusCode) else {
//                    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
//                    print("Image download failed with status code: \(statusCode)")
//                    return
//                }
//                
//                // Створюємо нову новину
//                let newNews = SDNewsModel(title: article.title,
//                                          author: article.author ?? "",
//                                          name: article.source.name,
//                                          descriptionLabel: article.description ?? "",
//                                          content: article.content ?? "",
//                                          publishedAt: article.publishedAt,
//                                          url: article.url,
//                                          image: data,
//                                          category: category.rawValue)
//                
//                print("\(newNews.title)")
//                
//                // Оскільки робота з контекстом може вимагати виконання на головному потоці,
//                // обгортаємо виклик addArticle в DispatchQueue.main.async
//                DispatchQueue.main.async {
//                    self.swiftDataService.addArticle(article: newNews, modelContext: self.context)
//                }
//            }
//            
//            // Запускаємо завдання
//            task.resume()
//  
//    }
}
