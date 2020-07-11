//
//  BookDetailResponseModel.swift
//  BookSearcher
//
//  Created by roshka on 6/29/20.
//  Copyright © 2020 vel. All rights reserved.
//

import Foundation

// MARK: - BookDetailResponse
struct BookDetailResponseModel: Codable {
    let error, title, subtitle, authors: String?
    let language: String?
    let publisher, isbn10, isbn13, pages: String?
    let year, rating, desc, price: String?
    let image: String?
    let url: String?
    let pdf: [String: String]?
}
