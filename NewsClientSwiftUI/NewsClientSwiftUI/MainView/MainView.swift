//
//  MainView.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 14.03.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainView: View {
    
    @StateObject private var viewModel = MainViewModel()
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
                                    .padding()
                                    .background(selectedCategory == category ? Color.blue : Color.gray.opacity(0.2))
                                    .foregroundStyle(selectedCategory == category ? Color.white : Color.black)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }

                        }
                    })
                    .frame(height: 50)
                }
                .padding(.horizontal)
                
                List(viewModel.newsRequest?.articles ?? [], id: \.title) { article in
                    
                    HStack {
                        
                        if let urlString = article.urlToImage, let url = URL(string: urlString) {
                            WebImage(url: URL(string: article.urlToImage ?? ""))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .clipped()
                                .clipShape(.buttonBorder)
                                
                        } else {
                            Image("basicNews")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .clipShape(.buttonBorder)
                        }

                        Text(article.title)
                        
                    }
                    
                    
                }
                .onAppear {
                    viewModel.fetch(category: selectedCategory)
                }
                .navigationTitle("Home")
                .navigationBarTitleDisplayMode(.inline)
                
            }
        }
        
        
        
        
        

    }
}

#Preview {
    MainView()
}
