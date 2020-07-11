//
//  ITBookConstants.swift
//  BookSearcher
//
//  Created by user on 6/27/20.
//  Copyright © 2020 vel. All rights reserved.
//

import Foundation

enum ITBookEndpoints {
    case searchEndpoint(String, Int)
    case newsEndpoint
    case bookDetailEndpoint(String)
    
    var value: String! {
        switch self {
        case .searchEndpoint(let query, let page):
            return ITBookConstants.baseURL + ("/search/\(query)/\(page)"
                .trimmingCharacters(in: .whitespaces)
                .replacingOccurrences(of: " ", with: "+"))
        case .newsEndpoint:
            return ITBookConstants.baseURL + "/new"
        case .bookDetailEndpoint(let isbn13):
            return ITBookConstants.baseURL + "/books/\(isbn13)"
        }
    }
}

struct ITBookConstants {
    //References were taken from https://api.itbook.store/
    static let baseURL = "https://api.itbook.store/1.0"
}
