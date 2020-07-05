//
//  UITableView+Extension.swift
//  BookSearcher
//
//  Created by user on 6/28/20.
//  Copyright © 2020 vel. All rights reserved.
//

import UIKit

extension UITableView {
    func setTextBackgroundView(with text: String) {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        backgroundView = label
        
        label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func clearBackgroundView() {
        backgroundView = nil
    }
}
