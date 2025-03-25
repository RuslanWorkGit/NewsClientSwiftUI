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
//    
//    let modelContainer: ModelContainer
    //private var modelContext: ModelContext?
    
    private init() {
//        let schema = Schema([SDNewsModel.self])
//        modelContainer = try! ModelContainer(for: schema)
        //modelContext = modelContainer?.mainContext
    }
    
    func addArticle(article: SDNewsModel, modelContext: ModelContext) {
//        guard let modelContext else {
//            print("ModelContext ADD!!!!")
//            return
//        }
        modelContext.insert(article)

    }
    
    func fetchArticle(categorys: String, modelContext: ModelContext) -> [SDNewsModel] {
//        guard let modelContext else {
//            print("ModelContext!!!")
//            return []
//        }
        
        let predicate = #Predicate<SDNewsModel> { $0.category == categorys }
        let descriptor = FetchDescriptor<SDNewsModel>(predicate: predicate, sortBy: [SortDescriptor(\.publishedAt, order: .reverse)])
        
        do {
            let results = try modelContext.fetch(descriptor)
            return results
        } catch {
            print("Error fetch by category")
            return []
        }
    }
    
    func fetchArticleUrl(with url: String, context: ModelContext) -> SDNewsModel? {
        let predicate = #Predicate<SDNewsModel> { $0.url == url}
        let descriptor = FetchDescriptor<SDNewsModel>(predicate: predicate)
        
        do {
            return try context.fetch(descriptor).first

        } catch {
            print("Error fetch by URL")
            return nil
        }
        
    }
    
    func existsArticle(with url: String, modelContext: ModelContext) -> Bool {
//        guard let modelContext else {
//            print("ModelContext!!!")
//            return false
//        }
        
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
    
    func deleteAll(modelContext: ModelContext) {
//        guard let modelContext else { return }
        
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
