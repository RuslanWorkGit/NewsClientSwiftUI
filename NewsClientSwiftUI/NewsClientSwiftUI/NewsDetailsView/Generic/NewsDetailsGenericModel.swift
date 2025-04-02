//
//  NewsDetailsGenericModel.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 27.03.2025.
//
import Foundation

protocol NewsDetailsDisplay {
    var titleDetails: String { get }
    var authorDetails: String { get }
    var publishedAtDetailsc: String { get }
    var contentDetails: String { get }
    var imageDetails: String? { get }
    var nameDetails: String { get }
    var urlDetails: String { get }
    var descriptionDetails: String { get }
}

extension Articles: NewsDetailsDisplay {
    
    var titleDetails: String {
        return title
    }
    
    var authorDetails: String {
        return author ?? ""
    }
    
    var publishedAtDetailsc: String {
        return publishedAt
    }
    
    var contentDetails: String {
        return content ?? ""
    }
    
    var imageDetails: String? {
        return urlToImage
    }
    
    var nameDetails: String {
        return source.name
    }
    
    var urlDetails: String {
        return url
    }
    
    var descriptionDetails: String {
        return description ?? ""
    }
    
}

//extension SDNewsModel: NewsDetailsDisplay {
//    var titleDetails: String {
//        return title
//    }
//    
//    var authorDetails: String {
//        return author
//    }
//    
//    var publishedAtDetailsc: String {
//        return publishedAt
//    }
//    
//    var contentDetails: String {
//        return content
//    }
//    
//    var imageDetails: Data? {
//        return image
//    }
//    
//    var nameDetails: String {
//        return name
//    }
//    
//    var urlDetails: String {
//        return url
//    }
//    
//    var descriptionDetails: String {
//        return descriptionLabel
//    }
//    
//    
//}
