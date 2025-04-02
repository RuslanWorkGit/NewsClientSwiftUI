//
//  NewsClientSwiftUIApp.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 13.03.2025.
//

import SwiftUI
import SwiftData

@main
struct NewsClientSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                
        }
        .modelContainer(for: SDNewsModel.self)
    }
        
}
