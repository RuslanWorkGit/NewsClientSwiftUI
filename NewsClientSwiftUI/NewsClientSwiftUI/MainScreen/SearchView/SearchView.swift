//
//  SearchView.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 14.03.2025.
//

import SwiftUI

enum SortOption {
    case none
    case newest
    case popularity
}

struct SearchView: View {
    
    @StateObject private var viewModel = SearchViewModel()
    @State private var searchText: String = ""
    @State private var isSerching: Bool = false
//    @State private var sortByNewest: Bool = false
//    @State private var sortByPopularity: Bool = false
    @State private var selectedSort: SortOption = .none
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .onSubmit {
                        
                        isSerching = true
                        
                        switch selectedSort {
                        case .none:
                            viewModel.fetchSearch(search: searchText)
                        case .newest:
                            viewModel.fetchSearch(search: searchText, searchByPublishing: true)
                        case .popularity:
                            viewModel.fetchSearch(search: searchText, sortByPopularity: true)
                        }
                    }
                
                NavigationLink(destination: SearchResultsView(articles: viewModel.searchNews?.articles ?? [], searchTitle: searchText), isActive: $isSerching) {
                    EmptyView()
                }
                
                VStack {
                    
                    Toggle("Sort by newest", isOn: Binding(get: {
                        selectedSort == .newest
                    }, set: { newValue in
                        selectedSort = newValue ? .newest : .none
                    }))

                    
                    Toggle("Sort by popularity", isOn: Binding(get: {
                        selectedSort == .popularity
                    }, set: { newValue in
                        selectedSort = newValue ? .popularity : .none
                    }))
                    

                }
                .padding()
                
                Spacer()
                
                
            }
            .navigationTitle("Search")
        }
        
            
    }
}

#Preview {
    SearchView()
}
