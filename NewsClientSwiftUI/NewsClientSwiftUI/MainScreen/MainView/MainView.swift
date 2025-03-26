//
//  MainView.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 14.03.2025.
//

import SwiftUI
import SDWebImageSwiftUI
import Lottie

struct MainView: View {
    
    @StateObject var viewModel: MainViewModel
    @State private var selectedCategory: Category = .general
    @State private var animationLoad: Bool = true
    
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
                
                ZStack {
                    SavedNewsList(savedArticles: viewModel.savedNews)
                        .opacity(animationLoad ? 0 : 1)
                    
                    if animationLoad {
                        Color.white.opacity(0.8)
                            .edgesIgnoringSafeArea(.all)
                        LottieView(animation: .named("loadAnimation"))
                            .playing()
                            .frame(width: 100, height: 100)
                    }
                }
            }
        }
        .onAppear {
            if viewModel.savedNews.isEmpty {
                viewModel.fetch(category: selectedCategory)
            }
        }
        .onChange(of: viewModel.savedNews) {
            if !viewModel.savedNews.isEmpty {
                withAnimation {
                    animationLoad = false
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.fetch(category: selectedCategory)
                }
                label: {
                    Image(systemName: "arrow.trianglehead.2.clockwise")
                }
            }
            
            ToolbarItem(placement: .automatic) {
                Text("Home")
            }
        }
    }
}
        


