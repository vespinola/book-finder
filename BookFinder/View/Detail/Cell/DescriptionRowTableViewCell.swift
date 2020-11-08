//
//  DescriptionRowTableViewCell.swift
//  BookSearcher
//
//  Created by user on 6/28/20.
//  Copyright © 2020 vel. All rights reserved.
//

import UIKit

class DescriptionRowTableViewCell: UITableViewCell {
    static let reuseIdentifier = "DescriptionRowTableViewCellReuseID"
    static let nibName = "DescriptionRowTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
}
