//
//  SearchResultsView.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 28.03.2025.
//

import SwiftUI

struct SearchResultsView: View {
    
    var articles: [Articles]
    var searchTitle: String
    
    var body: some View {
        VStack {
            NewsList(articles: articles)
        }
        .navigationTitle(searchTitle)
        
    }
        
}

#Preview {
    //SearchResultsView()
}
