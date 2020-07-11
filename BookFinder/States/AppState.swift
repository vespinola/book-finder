//
//  MainState.swift
//  BookSearcher
//
//  Created by user on 6/21/20.
//  Copyright © 2020 vel. All rights reserved.
//

import Foundation
import ReSwift

struct AppState: StateType {
    var bookListState: BookListState = BookListState()
}
