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
        state.searchRequestState = .initial
        state.searchState = .cancelled
        state.errorState = .none
        state.pages = Pages<BookModel>()
        state.selectedBookState = .unselected
    case .getBooks(let query):
        state.searchRequestState = .loading
        state.searchState = .searching(query)
        state.errorState = .none
        state.pages = Pages<BookModel>()
        state.selectedBookState = .unselected
    case .set(let response):
        state.searchRequestState = .loaded(response)
        state.pages.add(totalPages: Int(response.total!)!, values: response.books ?? [])
        state.errorState = .none
        state.selectedBookState = .unselected
    case .showError(let message):
        state.searchRequestState = .initial
        state.searchState = .cancelled
        state.errorState = .error(message)
        state.pages = Pages<BookModel>()
        state.selectedBookState = .unselected
    case .showDetail(let bookDetail):
        state.bookDetailState = .loaded(bookDetail)
        state.selectedBookState = .unselected
        state.errorState = .none
    case .selectBook(let book):
        state.selectedBookState = .selected(book)
        state.bookDetailState = .loading
        state.errorState = .none
    case .clearDetail:
        state.bookDetailState = .initial
    default:
        break
    }
    
    return state
}
