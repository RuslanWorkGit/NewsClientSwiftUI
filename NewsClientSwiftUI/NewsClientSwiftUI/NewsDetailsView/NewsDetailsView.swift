//
//  NewsDetailsView.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 17.03.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewsDetailsView: View {
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
                    Link("Read more", destination: url)
                        .font(.headline)
                        .foregroundStyle(Color.blue)
                }
                
            }
        }
    }
}

#Preview {
    NewsDetailsView(article: Articles(source: Source(id: "", name: "One"), title: "One", url: "One", publishedAt: "One"))
}
