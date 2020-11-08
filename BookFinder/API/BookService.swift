//
//  BookService.swift
//  BookSearcher
//
//  Created by user on 6/27/20.
//  Copyright © 2020 vel. All rights reserved.
//

import Foundation

protocol BookServiceProtocol {
    func getBook(by query: String, page: Int, onSuccess: @escaping (SearchResponseModel) -> Void, onError: @escaping (String) -> Void)
    func getNewBooks(onSuccess: @escaping (SearchResponseModel) -> Void, onError: @escaping (String) -> Void)
    func getBook(by isnb13: String, onSuccess: @escaping (BookDetailResponseModel) -> Void, onError: @escaping (String) -> Void)
}

class BookService: BookServiceProtocol {
    func getBook(by isnb13: String, onSuccess: @escaping (BookDetailResponseModel) -> Void, onError: @escaping (String) -> Void) {
        let endpoint = ITBookEndpoints.bookDetailEndpoint(isnb13).value ?? ""
        
        APIClient.request(verb: .get, endpoint: endpoint, success: { (response: BookDetailResponseModel) in
            onSuccess(response)
        }, failure: {
            onError($0.message)
        })
    }
    
    func getNewBooks(onSuccess: @escaping (SearchResponseModel) -> Void, onError: @escaping (String) -> Void) {
        let endpoint = ITBookEndpoints.newsEndpoint.value ?? ""
        
        APIClient.request(verb: .get, endpoint: endpoint, success: { (response: SearchResponseModel) in
            onSuccess(response)
        }, failure: {
            onError($0.message)
        })
    }
    
    func getBook(by query: String, page: Int, onSuccess: @escaping (SearchResponseModel) -> Void, onError: @escaping (String) -> Void) {
        let endpoint = ITBookEndpoints.searchEndpoint(query, page).value ?? ""
        
        APIClient.request(verb: .get, endpoint: endpoint, success: { (response: SearchResponseModel) in
            onSuccess(response)
        }, failure: {
            onError($0.message)
        })
    }
}
