//
//  SDNewsModel.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 23.03.2025.
//

import Foundation
import SwiftData

@Model
class SDNewsModel {
    
    var title: String
    var author: String
    var name: String
    var descriptionLabel: String
    var content: String
    var publishedAt: String
    var url: String
    var image: Data
    var category: String
    
    
    init(title: String, author: String, name: String, descriptionLabel: String, content: String, publishedAt: String, url: String, image: Data, category: String) {
        self.title = title
        self.author = author
        self.name = name
        self.descriptionLabel = descriptionLabel
        self.content = content
        self.publishedAt = publishedAt
        self.url = url
        self.image = image
        self.category = category
    }
}
