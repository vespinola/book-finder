//
//  BookSearcherTests.swift
//  BookSearcherTests
//
//  Created by user on 6/21/20.
//  Copyright © 2020 vel. All rights reserved.
//

import ReSwift
import XCTest
@testable import BookSearcher

struct EmptyAction: Action { }

class BookSearcherTests: XCTestCase {

    func testInitialState() {
        let state = mainReducer(action: EmptyAction(), state: nil)
        XCTAssertEqual(state, AppState())
    }
    
    func testGetBooks() {
        let action = BookListAction.getBooks("redux")
        let state = mainReducer(action: action, state: nil)
        
        guard case .loading = state.bookListState.searchRequestState else {
            return XCTFail()
        }
    }

    func testSetBooks() {
        let response = SearchResponseModel(books: [], total: "0")
        
        let action = BookListAction.set(response)
        let state = mainReducer(action: action, state: nil)
        guard case .loaded(_) = state.bookListState.searchRequestState else {
            return XCTFail()
        }
    }
    
    func testSearch() {
        let action = BookListAction.getBooks("search")

        let state = mainReducer(action: action, state: nil)

        guard case let .searching(search) = state.bookListState.search else {
            return XCTFail()
        }

        XCTAssert(search == "search")
    }

    func testCancelSearch() {
        let action = BookListAction.clearSearch

        let state = mainReducer(action: action, state: nil)

        guard case .cancelled = state.bookListState.search else {
            return XCTFail()
        }
    }
}
