//
//  SavedNewsDetailsView.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 24.03.2025.
//


import SwiftUI

struct SavedNewsDetailsView: View {
    
    @StateObject var viewModel: SavedNewsDetailsViewModel
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
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                } else {
                    Image("basicNews")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
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
        .navigationTitle("Details")
        .onAppear{
            isFavorite = viewModel.chechIfSaved(article: savedArticle)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                    if isFavorite {
                        print("Remover from save")
                        viewModel.delete(article: savedArticle)
                        isFavorite = false
                        
                    } else {
                        print("save")
                        viewModel.save(article: savedArticle)
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

