//
//  NewsList.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 17.03.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewsList: View {
    @Environment(\.modelContext) private var context
    let articles: [Articles]
    
    @State private var displayCount: Int = 20
    
    var body: some View {
        List {
            ForEach(Array(articles.prefix(displayCount).enumerated()), id: \.element.url) { index, article in
                NavigationLink(destination: NewsDetailsView(viewModel: NewsDetailsViewModel(context: context), article: article)) {
                    HStack {
                        if let urlStrign = article.urlToImage, let url = URL(string: urlStrign )  {
                            WebImage(url: url)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .clipped()
                                .clipShape(.buttonBorder)
                        } else {
                            Image("basicNews")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .clipped()
                                .clipShape(.buttonBorder)
                        }
                        
                        VStack {
                            Text(article.title)
                            
                            Text(dataFormater(article.publishedAt))
                        }
                    }
                }
                .onAppear {
                    if index == displayCount - 1 && displayCount < articles.count {
                        displayCount += 20
                    }
                }
            }

        }

    }
    
    func dataFormater(_ dataString: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        guard let data = isoFormatter.date(from: dataString) else { return dataString }
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "yyyy.MM.dd HH:mm"
        return displayFormatter.string(from: data)
    }
}

