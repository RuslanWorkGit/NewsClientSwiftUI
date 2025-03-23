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
}
