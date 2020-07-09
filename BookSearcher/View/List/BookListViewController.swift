//
//  BookListViewController.swift
//  BookSearcher
//
//  Created by user on 6/21/20.
//  Copyright © 2020 vel. All rights reserved.
//

import UIKit
import ReSwift
import Nuke

class BookListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate var books: [BookModel] {
        store.state.bookListState.books
    }
    
    fileprivate var descriptionView: SectionHeaderView = { SectionHeaderView() }()
    
    fileprivate var isLoading: Bool {
        set { _isLoading = newValue }
        get { _isLoading }
    }
    
    fileprivate var _isLoading: Bool! {
        didSet {
            view.isUserInteractionEnabled = !_isLoading
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "IT Bookstore"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always

        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = R.string.localizable.searchBook()
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableHeaderView = descriptionView
        
        descriptionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.register(UINib(nibName: BookItemTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: BookItemTableViewCell.reuseIdentifier)
        
        view.addSubview(searchController.searchBar)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        store.subscribe(self) {
            $0.select {
                $0.bookListState
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        store.unsubscribe(self)
    }
    
    fileprivate func performToDetail(for detail: BookDetailResponseModel) {
        guard let bookDetailViewController = BookDetailViewController.newInstante(book: detail) else { return }
        navigationController?.pushViewController(bookDetailViewController, animated: true)
    }
}

extension BookListViewController: StoreSubscriber {
    typealias StoreSubscriberStateType = BookListState
    
    func newState(state: BookListState) {
        switch state.searchResponseState {
        case .initial:
            switch state.error {
            case .error(let message):
                descriptionView.set(text: message)
                tableView.reloadData()
            default:
                descriptionView.set(text: R.string.localizable.newReleases())
                store.dispatch(getNewBooks)
            }
        case .loading:
            store.dispatch(getMoreBooks)
        case .loaded(let response):
            if let searchBarText = searchController.searchBar.text, !searchBarText.isEmpty {
                
                if response.books?.isEmpty ?? true {
                    descriptionView.set(text: R.string.localizable.noMatchesFor(searchBarText))
                } else {
                    descriptionView.set(text: R.string.localizable.resultsFor(searchBarText))
                }
                
            }
            
            tableView.reloadData()
            
        case .error(let message):
            descriptionView.set(text: message)
        }
        
        switch state.selectedBook {
        case .selected(_):
            store.dispatch(getDetail)
        default:
            break
        }
        
        switch state.bookDetailResponseState {
        case .loaded(let detail):
            performToDetail(for: detail)
            isLoading = false
        case .error(let message):
            descriptionView.set(text: message)
            isLoading = false
        default:
            break
        }
    }
}

extension BookListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        store.dispatch(BookListAction.clearSearch)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text, !query.isEmpty else { return }
        store.dispatch(BookListAction.getBooks(query))
    }
}

extension BookListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { books.count }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let book = books[indexPath.row]
        store.dispatch(BookListAction.selectBook(book))
        isLoading = true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookItemTableViewCell.reuseIdentifier, for: indexPath) as! BookItemTableViewCell
        guard !books.isEmpty else { return cell }
        
        let book = books[indexPath.row]
        
        cell.label?.text = book.title
        cell.subtitleLabel.text = book.subtitle
        
        if let url = URL(string: book.image ?? "") {
            Nuke.loadImage(with: url, into: cell.bookImageView)
        }
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == books.count - 1 else { return }
        store.dispatch(getMoreBooks)
    }
}

