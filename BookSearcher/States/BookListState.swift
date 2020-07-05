//
//  BookListState.swift
//  BookSearcher
//
//  Created by user on 6/27/20.
//  Copyright © 2020 vel. All rights reserved.
//

import Foundation
import ReSwift

struct BookListState: StateType {
    var searchResponseState: RequestState<SearchResponseModel> = .initial
    var search: SearchState = .ready
    var error: SearchErrorState = .none
    var pages = Pages<BookModel>()
    var selectedBook: SelectionState<BookModel> = .unselected
    var books: [BookModel] { pages.values }
    
    var bookDetailResponseState: RequestState<BookDetailResponseModel> = .initial
}

enum RequestState<T: Codable> {
    case initial
    case loading
    case loaded(T)
    case error(String)
    
    var value: T? {
        switch self {
        case .initial, .loading, .error(_):
            return nil
        case .loaded(let value): return value
        }
    }
}

enum SelectionState<T: Codable> {
    case unselected
    case selected(T)
}

enum SearchState {
    case cancelled
    case ready
    case searching(String)
}

enum SearchErrorState {
    case none
    case error(String)
}
