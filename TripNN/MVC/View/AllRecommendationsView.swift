//
//  AllRecommendationsView.swift
//  TripNN
//
//  Created by Pavel on 20.02.2024.
//

import UIKit

final class AllRecommendationsView: UIView {
    
    private var tableViewFilteredContent: [ItemCardModel] = []
    
    // MARK: - Closures
    
    var onSelectTableCellAction: (() -> Void)?
    
    // MARK: - Search Controller
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltered: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        return controller
    }()
    
    // MARK: - View
    
    private let tableViewContent: [ItemCardModel] = [
        ItemCardModel(image: UIImage(named: "place_1")!, type: .route, title: "Историческая часть города", costInfo: "0 – 500₽"),
        ItemCardModel(image: UIImage(named: "place_2")!, type: .route, title: "Большая Покровская улица", costInfo: "0₽"),
        ItemCardModel(image: UIImage(named: "place_3")!, type: .route, title: "Улица Рождественская", costInfo: "0₽"),
        ItemCardModel(image: UIImage(named: "place_4")!, type: .route, title: "Верхняя часть города", costInfo: "0₽")
    ]
    
    private let tableView: UITableView = .init()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        self.backgroundColor = .white
        setupView()
        setupConstraints()
        setupTableView()
        setupSearchController()
    }
    
    private func setupView() {
        self.addSubview(tableView)
    }
    
    private func setupTableView() {
        tableView.register(ItemCardTableViewCell.self, forCellReuseIdentifier: "ItemCardCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.searchBarStyle = .minimal
    }
    
    private func setupConstraints() {
        setupTableViewConstraints()
    }
    
    // MARK: - Constraints
    
    private func setupTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension AllRecommendationsView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltered {
            tableViewFilteredContent.count
        } else {
            tableViewContent.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCardCell", for: indexPath) as? ItemCardTableViewCell else { fatalError() }
        
        var content: ItemCardModel
        
        if isFiltered {
            content = tableViewFilteredContent[indexPath.row]
        } else {
            content = tableViewContent[indexPath.row]
        }
        
        cell.configure(cardModel: content)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelectTableCellAction?()
    }
    
//    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//            let deleteAction = UIContextualAction(
//                style: .normal,
//                title:  nil,
//                handler: { [weak self] (_, _, success: (Bool) -> Void) in
//                    success(true)
//                    print("Your action in here")
//                }
//            )
//            
//            deleteAction.image = UISwipeActionsConfiguration.makeTitledImage(
//                image: UIImage(named: "delete-favourites"),
//                title: "Удалить из избранных")
//        
//            deleteAction.backgroundColor = .tripnnWhite
//            return UISwipeActionsConfiguration(actions: [deleteAction])
//    }
    
}

extension AllRecommendationsView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        tableViewFilteredContent = tableViewContent.filter({ (content: ItemCardModel) -> Bool in
            return content.title.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
}
