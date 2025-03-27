//
//  Constant.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 14.03.2025.
//

import Foundation

enum Category: String, CaseIterable {
    case business
    case general
    case entertainment
    case health
    case science
    case sport
    case technology
}

enum EndPoints: String {
    case everything = "/v2/everything?"
    case topHeadLines = "/v2/top-headlines?"
}

struct ApiLink {
    private let mainLink = "https://newsapi.org"
    private let apiKey = "37beefb7966b4f568c9f18718ca7b11d"
    
    func bildUrl(endpoints: EndPoints, category: Category? = nil, search: String? = nil) -> URL? {
        
        let fullLink = mainLink + endpoints.rawValue
        var components = URLComponents(string: fullLink)
        var queryItems = [URLQueryItem]()
        
        if let addCategory = category?.rawValue {
            queryItems.append(URLQueryItem(name: "category", value: addCategory))
        }
        
        if let addSearch = search {
            queryItems.append(URLQueryItem(name: "q", value: addSearch))
        }
        
        queryItems.append(URLQueryItem(name: "apiKey", value: apiKey))
        
        components?.queryItems = queryItems
        return components?.url
        
    }
}

func dowloadImage(from imageStringUrl: String) -> Data? {
    
    var imageData: Data?
    
    guard let url = URL(string: imageStringUrl) else {
        print("Wrong link!")
        return nil
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        
        if let responseError = error {
            print("Error: \(responseError)")
        }
        
        guard let responseData = data else {
            print("Wrong data")
            return
        }

        imageData = responseData
    }
    
    return imageData
}
