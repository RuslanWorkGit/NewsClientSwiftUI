//
//  SearchViewModel.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 17.03.2025.
//

import Foundation

class SearchViewModel: ObservableObject {
    
    private let networkService: NetworkServiceProtocol
    private let apiLink = ApiLink()
    
    @Published var searchNews: SearchModel?
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchSearch(search: String, searchByPublishing: Bool = false, sortByPopularity: Bool = false) {
        guard let url = apiLink.bildUrl(endpoints: .everything, search: search, sortByPublishing: searchByPublishing, sortByPopularity: sortByPopularity) else {
            print("Wrong url!")
            return
        }
        
        networkService.fetch(with: url) { (result: Result<SearchModel, Error>) in
            switch result {
            case .success(let success):
                self.searchNews = success
            case .failure(let failure):
                print("Error: \(failure)")
            }
        }
    }
}
