//
//  SearchView.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 14.03.2025.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var viewModel = SearchViewModel()
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .onSubmit {
                        viewModel.fetchSearch(search: searchText)
                    }
                
                NewsList(articles: viewModel.searchNews?.articles ?? [])
            }
        }
        
            
    }
}

#Preview {
    SearchView()
}
