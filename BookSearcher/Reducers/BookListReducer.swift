//
//  BookListReducer.swift
//  BookSearcher
//
//  Created by user on 6/27/20.
//  Copyright © 2020 vel. All rights reserved.
//

import Foundation
import ReSwift

func bookListReducer(action: Action, state: BookListState?) -> BookListState {
    var state = state ?? BookListState()
    
    switch action as? BookListAction {
    case .clearSearch:
        state.searchResponseState = .initial
        state.search = .cancelled
        state.error = .none
        state.pages = Pages<BookModel>()
        state.selectedBook = .unselected
    case .getBooks(let query):
        state.searchResponseState = .loading
        state.search = .searching(query)
        state.error = .none
        state.pages = Pages<BookModel>()
        state.selectedBook = .unselected
    case .set(let response):
        state.searchResponseState = .loaded(response)
        state.pages.add(totalPages: Int(response.total!)!, values: response.books ?? [])
        state.error = .none
        state.selectedBook = .unselected
    case .showError(let message):
        state.searchResponseState = .initial
        state.search = .cancelled
        state.error = .error(message)
        state.pages = Pages<BookModel>()
        state.selectedBook = .unselected
    case .showDetail(let bookDetail):
        state.bookDetailResponseState = .loaded(bookDetail)
        state.selectedBook = .unselected
        state.error = .none
    case .selectBook(let book):
        state.selectedBook = .selected(book)
        state.bookDetailResponseState = .loading
        state.error = .none
    case .clearDetail:
        state.bookDetailResponseState = .initial
    default:
        break
    }
    
    return state
}
