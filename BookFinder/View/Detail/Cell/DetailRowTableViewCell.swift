//
//  DetailRowTableViewCell.swift
//  BookSearcher
//
//  Created by user on 6/28/20.
//  Copyright © 2020 vel. All rights reserved.
//

import UIKit

class DetailRowTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    static let reuseIdentifier = "DetailRowTableViewCellReuseID"
    static let nibName = "DetailRowTableViewCell"
}
