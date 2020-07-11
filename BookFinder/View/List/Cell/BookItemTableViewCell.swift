//
//  BookItemTableViewCell.swift
//  BookSearcher
//
//  Created by user on 6/27/20.
//  Copyright © 2020 vel. All rights reserved.
//

import UIKit

class BookItemTableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    static let reuseIdentifier = "BookItemTableViewCellReuseID"
    static let nibName = "BookItemTableViewCell"
     
}
