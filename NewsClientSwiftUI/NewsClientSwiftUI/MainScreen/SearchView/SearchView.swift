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
    @State private var selectedSort: SortOption = .none
    
    @State private var showDataPicker: Bool = false
    @State private var fromData: Date = Date()
    @State private var toData: Date = Date()
    
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
                            
                            if showDataPicker {
                                viewModel.fetchSearch(search: searchText, from: fromData, to: fromData)
                            } else {
                                viewModel.fetchSearch(search: searchText)
                            }
                            
                        case .newest:
                            viewModel.fetchSearch(search: searchText, searchByPublishing: true)
                            
                            if showDataPicker {
                                viewModel.fetchSearch(search: searchText, searchByPublishing: true, from: fromData, to: fromData)
                            } else {
                                viewModel.fetchSearch(search: searchText, searchByPublishing: true)
                            }
                            
                        case .popularity:
                            
                            if showDataPicker {
                                viewModel.fetchSearch(search: searchText, sortByPopularity: true, from: fromData, to: fromData)
                            } else {
                                viewModel.fetchSearch(search: searchText, sortByPopularity: true)
                            }
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
                    
                    Toggle("Choose date for news", isOn: $showDataPicker)
                    
                    if showDataPicker {
                        DatePicker("From", selection: $fromData, displayedComponents: .date)
                        DatePicker("To", selection: $toData, displayedComponents: .date)
                    }
                    
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
