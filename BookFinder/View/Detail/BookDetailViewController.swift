//
//  BookDetailViewController.swift
//  BookSearcher
//
//  Created by user on 6/28/20.
//  Copyright © 2020 vel. All rights reserved.
//

import UIKit
import Nuke

fileprivate enum BookDetailRowType {
    case normal
    case large
    case link
}

fileprivate struct BookDetailRow {
    var title: String
    var content: String?
    var type: BookDetailRowType = .normal
}

class BookDetailViewController: UIViewController {
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var sections: [[BookDetailRow]] = []
    fileprivate var urlString: String? { book.url }
    fileprivate var book: BookDetailResponseModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = book.title
        
        tableView.register(
            UINib(nibName: DetailRowTableViewCell.nibName, bundle: nil),
            forCellReuseIdentifier: DetailRowTableViewCell.reuseIdentifier
        )
        
        tableView.register(
            UINib(nibName: DescriptionRowTableViewCell.nibName, bundle: nil),
            forCellReuseIdentifier: DescriptionRowTableViewCell.reuseIdentifier
        )
        
        tableView.register(
            UINib(nibName: DetailLinkTableViewCell.nibName, bundle: nil),
            forCellReuseIdentifier: DetailLinkTableViewCell.reuseIdentifier
        )
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .grayBackgroundColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(shareButtonTapped))
        
        createDataSource(for: book)
        setBookImage(with: book.image)
       
        store.dispatch(BookListAction.clearDetail)
    }
    
    @objc fileprivate func shareButtonTapped() {
        guard let urlString = urlString else { return }
        let objectsToShare:URL = URL(string: urlString)!
        let sharedObjects:[AnyObject] = [objectsToShare as AnyObject]
        let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view

        activityViewController.excludedActivityTypes = [.airDrop, .mail]

        present(activityViewController, animated: true, completion: nil)
    }
    
    fileprivate func createDataSource(for book: BookDetailResponseModel) {
        sections = [
            [
                BookDetailRow(title: R.string.localizable.title(), content: book.title),
                BookDetailRow(title: R.string.localizable.subtitle(), content: book.subtitle),
                BookDetailRow(title: R.string.localizable.publisher(), content: book.publisher),
                BookDetailRow(title: R.string.localizable.language(), content: book.language),
                BookDetailRow(title: R.string.localizable.pages(), content: book.pages),
                BookDetailRow(title: R.string.localizable.rating(), content: "\(book.rating ?? "")/5"),
                BookDetailRow(title: "isbn10", content: book.isbn10),
                BookDetailRow(title: "isbn13", content: book.isbn13),
                
            ],
            [
                BookDetailRow(title: R.string.localizable.desc(), content: book.desc, type: .large),
            ],
            [
                BookDetailRow(title: R.string.localizable.price(), content: book.price),
            ]
        ]
        
        if let pdfs = book.pdf, !pdfs.isEmpty {
            
            let pdfSection = pdfs.map { title, link in
                BookDetailRow(title: title, content: link, type: .link)
            }
            
            sections.append(pdfSection)
        }
        
    }
    
    fileprivate func setBookImage(with urlString: String?) {
        guard let urlString = urlString else { return }
        guard let url = URL(string: urlString) else { return }
        
        Nuke.loadImage(with: url, into: bookImageView)
    }
}

extension BookDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { sections[section].count }
    
    func numberOfSections(in tableView: UITableView) -> Int { sections.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = sections[indexPath.section][indexPath.row]
        
        switch row.type {
        case .normal:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailRowTableViewCell.reuseIdentifier, for: indexPath) as! DetailRowTableViewCell
            
            cell.titleLabel.text = row.title
            cell.contentLabel.text = row.content
            
            return cell
        case .large:
            let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionRowTableViewCell.reuseIdentifier, for: indexPath) as! DescriptionRowTableViewCell
            
            cell.titleLabel.text = row.title
            cell.contentLabel.text = row.content
            
            return cell
        case .link:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailLinkTableViewCell.reuseIdentifier, for: indexPath) as! DetailLinkTableViewCell
            
            cell.titleLabel.text = row.title
            cell.previewOnTap = {
                guard let link = row.content, let url = URL(string: link) else { return }
                guard UIApplication.shared.canOpenURL(url) else { return }
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            
            return cell
        }
    }
}

extension BookDetailViewController {
    //MARK: Factory Method
    class func newInstante(book: BookDetailResponseModel) -> BookDetailViewController? {
        guard let bookDetailViewController = R.storyboard.main.bookDetailViewControllerID() else { return nil }
        bookDetailViewController.book = book
        return bookDetailViewController
    }
}
