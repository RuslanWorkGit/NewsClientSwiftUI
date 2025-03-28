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
    
    func bildUrl(endpoints: EndPoints,
                 category: Category? = nil,
                 search: String? = nil,
                 sortByPublishing: Bool = false,
                 sortByPopularity: Bool = false,
                 from: Date? = nil,
                 to: Date? = nil) -> URL? {
        
        let fullLink = mainLink + endpoints.rawValue
        var components = URLComponents(string: fullLink)
        var queryItems = [URLQueryItem]()
        let dateFormater = ISO8601DateFormatter()
        
        if let addCategory = category?.rawValue {
            queryItems.append(URLQueryItem(name: "category", value: addCategory))
        }
        
        if let addSearch = search {
            queryItems.append(URLQueryItem(name: "q", value: addSearch))
        }
        
        if let fromDate = from {
            queryItems.append(URLQueryItem(name: "from", value: dateFormater.string(from: fromDate)))
        }
        
        if let toDate = to {
            queryItems.append(URLQueryItem(name: "to", value: dateFormater.string(from: toDate)))
        }
        
        if sortByPublishing {
            queryItems.append(URLQueryItem(name: "sortBy", value: "publishedAt"))
        }
        
        if sortByPopularity {
            queryItems.append(URLQueryItem(name: "sortBy", value: "popularity"))
        }
        
        queryItems.append(URLQueryItem(name: "apiKey", value: apiKey))
        
        components?.queryItems = queryItems
        return components?.url
        
    }
}

func dowloadImage(from imageStringUrl: String, comletion: @escaping ((Data?) -> Void)) {
    
    guard let url = URL(string: imageStringUrl) else {
        print("Wrong link!")
        comletion(nil)
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        
        if let responseError = error {
            print("Error: \(responseError)")
            comletion(nil)
        }
        
        comletion(data)
    }
    
    task.resume()
}
