//
//  MainReducer.swift
//  BookSearcher
//
//  Created by user on 6/21/20.
//  Copyright © 2020 vel. All rights reserved.
//

import Foundation
import ReSwift

func mainReducer(action: Action, state: AppState?) -> AppState {
    let state = state ?? AppState()
    
    switch action {
    case let action as BookListAction:
        return AppState(bookListState: bookListReducer(action: action, state: state.bookListState))
    default:
        break
    }
    
    return state
}
