//
//  SwiftDataService.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 23.03.2025.
//

import Foundation
import SwiftData

@MainActor  
class SwiftDataService {
    
    static let shared = SwiftDataService()
    
    private let modelContainer: ModelContainer?
    private var modelContext: ModelContext?
    
    private init() {
        modelContainer = try? ModelContainer(for: Schema([SDNewsModel.self]))
        modelContext = modelContainer?.mainContext
    }
    
    func addArticle(article: SDNewsModel) {
        modelContext?.insert(article)
    }
    
//    func fetchAllArticles(url: String) -> SDNewsModel? {
//        guard let modelContext else { return nil }
//        
//        let predicator = #Predicate<SDNewsModel> { $0.url == url}
//        let decriptor = FetchDescriptor<SDNewsModel>(predicate: predicator)
//        
//        let results = try? modelContext.fetch(decriptor).first
//        return results
//    }
    
    func fetchArticle(category: String) -> [SDNewsModel] {
        guard let modelContext else { return [] }
        
        let predicator = #Predicate<SDNewsModel> { $0.category == category}
        let descriptor = FetchDescriptor<SDNewsModel>(predicate: predicator, sortBy: [SortDescriptor(\.publishedAt, order: .reverse)])
        
        do {
            let results = try modelContext.fetch(descriptor)
            return results
        } catch {
            print("Error fetch by category")
            return []
        }
    }
    
    func existsArticle(with url: String) -> Bool {
        guard let modelContext else { return false}
        
        let predicator = #Predicate<SDNewsModel> { $0.url == url }
        let fetchDescriptor = FetchDescriptor<SDNewsModel>(predicate: predicator)
        
        do {
            let results = try modelContext.fetch(fetchDescriptor)
            return !results.isEmpty
        } catch {
            print("Error find element: \(error.localizedDescription)")
            return false
        }
    }
    
    func deleteAll() {
        guard let modelContext else { return }
        
        let descriptor = FetchDescriptor<SDNewsModel>()
        
        do {
            let allNews = try modelContext.fetch(descriptor)
            for item in allNews {
                modelContext.delete(item)
            }
            try modelContext.save()

        } catch {
            print("Error to delete")
        }
    }
    
}
