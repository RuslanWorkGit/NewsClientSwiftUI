//
//  SavedNewsList.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 24.03.2025.
//

import SwiftUI

struct SavedNewsList: View {
    @Environment(\.modelContext) private var context
    let savedArticles: [SDNewsModel]
    
    @State private var dispalayCount: Int = 20
    
    var body: some View {
        List {
            ForEach(Array(savedArticles.prefix(dispalayCount).enumerated()), id: \.element.url) { index, article in
                NavigationLink(destination: SavedNewsDetailsView(viewModel: SavedNewsDetailsViewModel(context: context), savedArticle: article))
                /*NavigationLink(destination: NewsDetailsGenericView(viewModel: NewsDetailsGenericViewModel(context: context), article: article))*/ {
                    HStack {
                        if let imageData = article.image {
                            if let image = UIImage(data: imageData) {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 80, height: 80)
                                    .clipped()
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
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
                .onAppear {
                    if index == dispalayCount - 1 && dispalayCount < savedArticles.count {
                        dispalayCount += 20
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

