//
//  MainViewModel.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 14.03.2025.
//

import Foundation

class MainViewModel: ObservableObject {
    
    private let networkService: NetworkServiceProtocol
    private let apiLink = ApiLink()
    
    @Published var newsRequest: NewsRequest?
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetch() {
        guard let url = apiLink.bildUrl(endpoints: .topHeadLines, category: .general) else {
            print("wrong link")
            return
        }
        
        networkService.fetch(with: url) { (result: Result<NewsRequest, Error>) in
            switch result {
            case .success(let success):
                self.newsRequest = success
            case .failure(let failure):
                print("Error: \(failure)")
            }
        }
    }
}
