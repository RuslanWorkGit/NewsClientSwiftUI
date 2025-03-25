//
//  MainView.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 14.03.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainView: View {
    
    @StateObject var viewModel: MainViewModel
    @State private var selectedCategory: Category = .general
    
    var body: some View {
        
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: [GridItem(.flexible())], content: {
                        ForEach(Category.allCases, id: \.self) { category in
                            
                            Button {
                                selectedCategory = category
                                viewModel.fetch(category: selectedCategory)
                            } label: {
                                Text(category.rawValue)
                                    .padding(10)
                                    .background(selectedCategory == category ? Color.blue : Color.gray.opacity(0.2))
                                    .foregroundStyle(selectedCategory == category ? Color.white : Color.black)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }

                        }
                    })
                    .frame(height: 50)
                }
                .padding(.horizontal)
  
//                NewsList(articles: viewModel.newsRequest?.articles ?? [])
//                    .onAppear {
//                        viewModel.fetch(category: selectedCategory)
//                    }
//                    .navigationTitle("Home")
//                    .navigationBarTitleDisplayMode(.inline)
                SavedNewsList(savedArticles: viewModel.savedNews)
                    .onAppear{
                        viewModel.fetch(category: selectedCategory)
                    }
//                SavedNewsList(savedArticles: viewModel.savedNews)
//                    .onAppear {
//                        Task {
//                            await viewModel.fetchAsync(category: selectedCategory)
//                        }
//                    }
//                    .navigationTitle("Home")
//                    .navigationBarTitleDisplayMode(.inline)
 
            }
        }

    }
}

#Preview {
    //MainView()
}
