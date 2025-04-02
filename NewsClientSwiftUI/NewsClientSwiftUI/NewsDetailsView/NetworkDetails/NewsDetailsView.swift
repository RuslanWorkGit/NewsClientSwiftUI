//
//  NewsDetailsView.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 17.03.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewsDetailsView: View {
    
    @StateObject var viewModel: NewsDetailsViewModel
    @State private var isFavorite: Bool = false
    var article: Articles
    
    
    var body: some View {
        
        ScrollView {
            VStack {
                
                Text(article.title)
                    .font(.title)
                    .fontWeight(.bold)
                
                
                if let urlString = article.urlToImage, let url = URL(string: urlString) {
                    WebImage(url: url)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                    
                } else {
                    Image("basicNews")
                }
                
                HStack {
                    Text(article.source.name)
                    
                    Spacer()
                    
                    Text(article.author ?? "No Author")
                }
                .padding()
                
                Text(article.description ?? "No decription")
                Text(article.publishedAt)
                
                if let url = URL(string: article.url) {
                    Link(article.url, destination: url)
                        .font(.headline)
                        .foregroundStyle(Color.blue)
                }
                
            }
        }
        .onAppear {
            isFavorite = viewModel.checkIsSavedInSD(article: article)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                    if isFavorite {
                        viewModel.deleteFromSD(article: article)
                        isFavorite = false
                    } else {
                        viewModel.saveToSD(article: article)
                        isFavorite = true
                    }
                    
                    
                } label: {
                    
                    if isFavorite {
                        Image(systemName: "star.fill")
                            .foregroundStyle(Color.yellow)
                    } else {
                        Image(systemName: "star")
                            .foregroundStyle(Color.yellow)
                    }
                    
                        
                }

            }
        }
    }
}

//#Preview {
//    NewsDetailsView(article: Articles(source: Source(id: "", name: "One"), title: "One", url: "One", publishedAt: "One"))
//}
