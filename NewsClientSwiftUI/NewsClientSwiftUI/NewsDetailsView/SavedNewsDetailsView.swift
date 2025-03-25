//
//  SavedNewsDetailsView.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 24.03.2025.
//


import SwiftUI

struct SavedNewsDetailsView: View {
    
    //@StateObject private var viewModel = NewsDetailsViewModel()
    @State private var isFavorite: Bool = false
    var savedArticle: SDNewsModel
    
    var body: some View {
        
        ScrollView {
            VStack {
                
                Text(savedArticle.title)
                    .font(.title)
                    .fontWeight(.bold)
                

                
                if let dataImage = savedArticle.image, let image = UIImage(data: dataImage) {
                    Image(uiImage: image)
                } else {
                    Image("basicNews")
                }
                
                HStack {
                    Text(savedArticle.name)
                    
                    Spacer()
                    
                    Text(savedArticle.author )
                }
                .padding()
                
                Text(savedArticle.descriptionLabel)
                Text(savedArticle.publishedAt)
                
                if let url = URL(string: savedArticle.url) {
                    Link(savedArticle.url, destination: url)
                        .font(.headline)
                        .foregroundStyle(Color.blue)
                }
                
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isFavorite.toggle()
                    
                    if isFavorite {
                        print("save")
                    } else {
                        print("Remover from save")
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

#Preview {
    SavedNewsDetailsView(savedArticle: SDNewsModel(title: "One", author: "One", name: "One", descriptionLabel: "One", content: "One", publishedAt: "One", url: "One", image: Data(), category: "general"))
}
