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
    
    var body: some View {
        
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: [GridItem(.flexible())], content: {
                        ForEach(Category.allCases, id: \.self) { category in
                            
                            Text(category.rawValue)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        }
                    })
                    .frame(height: 50)
                }
                .padding(.horizontal)
                
                List(viewModel.newsRequest?.articles ?? [], id: \.title) { article in
                    
                    HStack {
                        
                        if let url = URL(string: article.urlToImage ?? "") {
                            WebImage(url: URL(string: article.urlToImage ?? ""))
                                .resizable()
                                .frame(width: 80, height: 80)
                                .clipShape(.buttonBorder)
                        } else {
                            Image("basicNews")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .clipShape(.buttonBorder)
                        }
                        
                        
                        
        //                Image("basicNews")
        //                    .resizable()
        //                    .frame(width: 80, height: 80)
        //                    .clipShape(.buttonBorder)
                        Text(article.title)
                        
                    }
                    
                    
                }
                .onAppear {
                    viewModel.fetch()
                }
            }
        }
        
        
        
        
        

    }
}

#Preview {
    MainView()
}
