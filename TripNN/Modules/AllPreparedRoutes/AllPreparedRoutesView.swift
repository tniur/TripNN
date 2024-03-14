//
//  AllPreparedRoutesView.swift
//  TripNN
//
//  Created by Pavel on 20.02.2024.
//

import UIKit

final class AllPreparedRoutesView: UIView {
    
    private var allPreparedRoutesTableFilteredContent: [ItemCardModel] = []
    
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
    
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - View
    
    private let allPreparedRoutesTable: [ItemCardModel] = [
        ItemCardModel(image: UIImage(named: "route_1")!, type: .route, title: "Историческая часть города", costInfo: "0 – 500₽"),
        ItemCardModel(image: UIImage(named: "route_2")!, type: .route, title: "Большая Покровская улица", costInfo: "0₽"),
        ItemCardModel(image: UIImage(named: "route_3")!, type: .route, title: "Улица Рождественская", costInfo: "0₽"),
        ItemCardModel(image: UIImage(named: "route_4")!, type: .route, title: "Верхняя часть города", costInfo: "0₽")
    ]
    
    private let allPreparedRoutesTableView: UITableView = .init()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupView()
        setupConstraints()
        setupAllPreparedRoutesTableView()
        setupSearchController()
    }
    
    private func setupView() {
        self.backgroundColor = .tripnnWhite
        self.addSubview(allPreparedRoutesTableView)
    }
    
    private func setupAllPreparedRoutesTableView() {
        allPreparedRoutesTableView.register(ItemCardTableViewCell.self, forCellReuseIdentifier: "ItemCardCell")
        allPreparedRoutesTableView.dataSource = self
        allPreparedRoutesTableView.delegate = self
        allPreparedRoutesTableView.separatorStyle = .none
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.searchBarStyle = .minimal
    }
    
    private func setupConstraints() {
        setupAllPreparedRoutesTableViewConstraints()
    }
    
    // MARK: - Constraints
    
    private func setupAllPreparedRoutesTableViewConstraints() {
        allPreparedRoutesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            allPreparedRoutesTableView.topAnchor.constraint(equalTo: self.topAnchor),
            allPreparedRoutesTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            allPreparedRoutesTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            allPreparedRoutesTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension AllPreparedRoutesView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltered {
            allPreparedRoutesTableFilteredContent.count
        } else {
            allPreparedRoutesTable.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCardCell", for: indexPath) as? ItemCardTableViewCell else { fatalError() }
        
        var content: ItemCardModel
        
        if isFiltered {
            content = allPreparedRoutesTableFilteredContent[indexPath.row]
        } else {
            content = allPreparedRoutesTable[indexPath.row]
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

extension AllPreparedRoutesView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        allPreparedRoutesTableFilteredContent = allPreparedRoutesTable.filter({ (content: ItemCardModel) -> Bool in
            return content.title.lowercased().contains(searchText.lowercased())
        })
        
        allPreparedRoutesTableView.reloadData()
    }
}
