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
    
    init(books: [BookModel], total: String) {
        self.books = books
        self.error = nil
        self.total = total
        self.page = nil
    }
}

// MARK: - Book
struct BookModel: Codable, Equatable {
    var title, subtitle, isbn13, price: String?
    var image: String?
    var url: String?
}
