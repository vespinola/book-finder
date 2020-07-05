//
//  SearchResponseModel.swift
//  BookSearcher
//
//  Created by user on 6/21/20.
//  Copyright © 2020 vel. All rights reserved.
//

import Foundation

// MARK: - SearchResponseModel
struct SearchResponseModel: Codable {
    let error, total, page: String?
    let books: [BookModel]?
}

// MARK: - Book
struct BookModel: Codable, Equatable {
    var title, subtitle, isbn13, price: String?
    var image: String?
    var url: String?
}
