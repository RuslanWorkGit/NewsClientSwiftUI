//
//  SavedNewsList.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 24.03.2025.
//

import SwiftUI

struct SavedNewsList: View {
    let savedArticles: [SDNewsModel]
    
    var body: some View {
        List(savedArticles, id: \.url) { article in
            NavigationLink(destination: SavedNewsDetailsView(savedArticle: article)) {
                HStack {
                    if let image = UIImage(data: article.image) {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    } else {
                        Image("basicNews")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    VStack {
                        Text(article.title)
                        
                        Text("\(dataFormater(article.publishedAt)) S")
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

