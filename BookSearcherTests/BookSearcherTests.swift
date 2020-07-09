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

}
