//
//  SearchModel.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 17.03.2025.
//

struct SearchModel: Decodable {
    var status: String
    var totalResults: Int
    var articles: [Articles]
}


