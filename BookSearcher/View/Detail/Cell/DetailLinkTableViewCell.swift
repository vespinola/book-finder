//
//  DetailLinkTableViewCell.swift
//  BookSearcher
//
//  Created by roshka on 6/29/20.
//  Copyright © 2020 vel. All rights reserved.
//

import UIKit

class DetailLinkTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton!
    
    var previewOnTap: (() -> Void)? = nil
    
    static let reuseIdentifier = "DetailLinkTableViewCellReuseID"
    static let nibName = "DetailLinkTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        linkButton.setTitle(R.string.localizable.preview(), for: .normal)
    }
    
    @IBAction func previewButtonTapped(_ sender: Any) { previewOnTap?() }
}
