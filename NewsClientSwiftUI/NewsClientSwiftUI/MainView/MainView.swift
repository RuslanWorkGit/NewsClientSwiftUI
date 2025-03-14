//
//  MainView.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 14.03.2025.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        List(viewModel.newsRequest?.articles ?? [], id: \.title) { article in
            
            HStack {
                Image("basicNews")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .clipShape(.buttonBorder)
                Text(article.title)
            }
            
            
        }
        .onAppear {
            viewModel.fetch()
        }
    }
}

#Preview {
    MainView()
}
