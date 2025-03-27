//
//  NewsDetailsViewGeneric.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 27.03.2025.
//

import SwiftUI

struct NewsDetailsViewGeneric<T: NewsDetailsDisplay>: View {
    
    @StateObject var viewModel: NewsDetailsGenericViewModel
    @State private var isFavorite: Bool = false
    var article: T
    
    var body: some View {
        ScrollView {
            VStack {
                Text(article.titleDetails)
                    .font(.title)
                    .fontWeight(.bold)
                
                if let dataImage = article.imageDetails, let uiImage = UIImage(data: dataImage) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    Image("basicNews")
                }
                
                HStack {
                    Text(article.nameDetails)
                    
                    Spacer()
                    
                    Text(article.authorDetails)
                }
                
                Text(article.descriptionDetails)
                Text(article.contentDetails)
                Text(article.publishedAtDetailsc)
                
                if let url = URL(string: article.urlDetails) {
                    Link(article.urlDetails, destination: url)
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
