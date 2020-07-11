//
//  APIError.swift
//  BookSearcher
//
//  Created by user on 6/21/20.
//  Copyright © 2020 vel. All rights reserved.
//

import Foundation

enum APIErrorType: String {
    case timeout = "Timeout"
    case generic = "Generic"
    case connection = "Connection"
    case notFound = "Not found"
    case custom = ""
}

struct APIError: Error {
    private var type: APIErrorType = .custom
    
    var code: String
    var message: String
    
    init(code: String = "", message: String) {
        self.message = message
        self.code = code
    }
    
    init (type: APIErrorType = .custom) {
        self.message = type.rawValue
        self.code = ""
    }
}
