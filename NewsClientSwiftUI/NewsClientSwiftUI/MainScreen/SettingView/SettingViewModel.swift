//
//  SettingViewModel.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 25.03.2025.
//

import Foundation
import SwiftData

@MainActor
class SettingViewModel: ObservableObject {
    
    let context: ModelContext
    private let swiftDataService = SwiftDataService.shared
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func cleaneCache() {
        swiftDataService.deleteAll(modelContext: context)
    }
}
