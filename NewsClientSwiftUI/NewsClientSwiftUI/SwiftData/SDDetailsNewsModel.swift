//
//  SDDetailsNewsModel.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 25.03.2025.
//

import Foundation
import SwiftData

@Model
class SDDetailsNewsModel {
    
    var title: String
    var author: String
    var name: String
    var descriptionLabel: String
    var content: String
    var publishedAt: String
    var url: String
    var image: Data?
    
    
    init(title: String, author: String, name: String, descriptionLabel: String, content: String, publishedAt: String, url: String, image: Data?) {
        self.title = title
        self.author = author
        self.name = name
        self.descriptionLabel = descriptionLabel
        self.content = content
        self.publishedAt = publishedAt
        self.url = url
        self.image = image
    }
}
