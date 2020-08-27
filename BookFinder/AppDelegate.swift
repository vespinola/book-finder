//
//  AppDelegate.swift
//  BookSearcher
//
//  Created by user on 6/21/20.
//  Copyright © 2020 vel. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftThunk

let thunksMiddleware: Middleware<AppState> = createThunkMiddleware()

var store = Store(reducer: mainReducer, state: nil, middleware: [thunksMiddleware])

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
}

