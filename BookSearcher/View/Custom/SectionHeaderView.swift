//
//  SectionHeaderView.swift
//  BookSearcher
//
//  Created by user on 6/28/20.
//  Copyright © 2020 vel. All rights reserved.
//

import UIKit
import SnapKit

class SectionHeaderView: UIView {
    fileprivate lazy var label = UILabel()
    fileprivate lazy var containerView = UIView()
    
    fileprivate var requiredUpdateConstraints = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    fileprivate func configure() {
        addSubview(containerView)
        containerView.addSubview(label)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
    }
    
    func set(text: String) {
        label.text = text
    }
    
    override func updateConstraints() {
        if requiredUpdateConstraints {
            requiredUpdateConstraints = false
            
            containerView.snp.makeConstraints { $0.edges.equalToSuperview() }
            label.snp.makeConstraints {
                $0.top.equalTo(20)
                $0.bottom.equalToSuperview()
                $0.leading.equalTo(20)
                $0.trailing.equalTo(-20)
            }
        }
        
        super.updateConstraints()
    }
}
