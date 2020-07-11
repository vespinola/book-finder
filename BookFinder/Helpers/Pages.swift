//
//  Pages.swift
//  BookSearcher
//
//  Created by user on 6/28/20.
//  Copyright © 2020 vel. All rights reserved.
//

import Foundation

//Reference taken from ReduxMovieDB example

class Pages<T:Equatable>: NSObject {
    var values: [T] = []
    var currentPage = 0
    var totalPages = 0
}

extension Pages {
    func add(totalPages: Int, values: [T]) {
        guard totalPages != 0 else { return }
        self.totalPages = totalPages
        guard currentPage < totalPages else { return }
        currentPage += 1
        self.values.append(contentsOf: values)
    }
}
