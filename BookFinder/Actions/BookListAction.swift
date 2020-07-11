//
//  BookListAction.swift
//  BookSearcher
//
//  Created by user on 6/27/20.
//  Copyright © 2020 vel. All rights reserved.
//

import Foundation
import ReSwift
import ReSwiftThunk

let getMoreBooks = Thunk<AppState> { dispatch, getState in
    guard let state = getState() else { return }
    
    guard case .searching(let query) = state.bookListState.searchState else { return }
    let service: BookServiceProtocol = BookService()
    
    let nextPage = state.bookListState.pages.currentPage + 1
    
    service.getBook(by: query, page: nextPage, onSuccess: { response in
        DispatchQueue.main.async {
            dispatch(BookListAction.set(response))
        }
    }, onError: { error in
        DispatchQueue.main.async {
            dispatch(BookListAction.showError(error))
        }
    })
}

let getNewBooks = Thunk<AppState> { dispatch, getState in
    guard let state = getState() else { return }
    
    let searchState = state.bookListState.searchState
    
    switch searchState {
    case .ready, .cancelled:
        let service: BookServiceProtocol = BookService()
           
        service.getNewBooks(onSuccess: { response in
           DispatchQueue.main.async {
               dispatch(BookListAction.set(response))
           }
        }) { message in
           DispatchQueue.main.async {
              dispatch(BookListAction.clearSearch)
           }
        }
    default: 
        break
    }
   
}

let getDetail = Thunk<AppState> { dispatch, getState in
    guard let state = getState() else { return }
    
    guard case .selected(let selectBook) = state.bookListState.selectedBookState else { return }
    let service: BookServiceProtocol = BookService()

    service.getBook(by: selectBook.isbn13 ?? "" , onSuccess: { response in
       DispatchQueue.main.async {
           dispatch(BookListAction.showDetail(response))
       }
    }) { message in
       DispatchQueue.main.async {
          dispatch(BookListAction.clearSearch)
       }
    }
}

enum BookListAction: Action {
    case getNews
    case getBooks(String)
    case set(SearchResponseModel)
    case selectBook(BookModel)
    case showDetail(BookDetailResponseModel)
    case clearSearch
    case clearDetail
    case showError(String)
}
