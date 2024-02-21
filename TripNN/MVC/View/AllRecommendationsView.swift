//
//  AllRecommendationsView.swift
//  TripNN
//
//  Created by Pavel on 20.02.2024.
//

import UIKit

final class AllRecommendationsView: UIView {
    
    // MARK: - Closures
    
    var onNavigationBackButtonAction: (() -> Void)?
    
    // MARK: - View
    
    private let navigationBackButton: NavigationBackButton = {
        let button = NavigationBackButton()
        return button
    }()
    
    private let screenTitleLabel: ScreenTitleLabel = {
        let label = ScreenTitleLabel()
        label.configure(title: "Рекомендованные маршруты")
        return label
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
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
    
    // MARK: - Action
    
    @objc private func navigationBackButtonAction() {
        onNavigationBackButtonAction?()
    }
    
    // MARK: - Setup
    
    private func setup() {
        self.backgroundColor = .white
        setupView()
        setupConstraints()
        setupAction()
        setupTableView()
    }
    
    private func setupView() {
        self.addSubview(navigationBackButton)
        self.addSubview(screenTitleLabel)
        self.addSubview(tableView)
        self.addSubview(searchBar)
    }
    
    private func setupTableView() {
        tableView.register(ItemCardTableViewCell.self, forCellReuseIdentifier: "ItemCardCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    private func setupConstraints() {
        setupNavigationBackButtonConstraints()
        setupScreenTitleLabelConstraints()
        setupTableViewConstraints()
        setupSearchBarConstraints()
    }
    
    private func setupAction() {
        navigationBackButton.setupAction(target: self, buttonAction: #selector(navigationBackButtonAction))
    }
    
    // MARK: - Constraints
    
    private func setupNavigationBackButtonConstraints() {
        navigationBackButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationBackButton.widthAnchor.constraint(equalToConstant: 44),
            navigationBackButton.heightAnchor.constraint(equalToConstant: 44),
            navigationBackButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            navigationBackButton.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
    
    private func setupScreenTitleLabelConstraints() {
        screenTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            screenTitleLabel.topAnchor.constraint(equalTo: navigationBackButton.bottomAnchor),
            screenTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            screenTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        ])
    }
    
    private func setupSearchBarConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: screenTitleLabel.bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 7),
            searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -7),
        ])
    }
    
    private func setupTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension AllRecommendationsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCardCell", for: indexPath) as? ItemCardTableViewCell else { fatalError() }
        
        cell.configure(cardModel: tableViewContent[indexPath.row])
        
        return cell
    }
}

extension AllRecommendationsView: UITableViewDelegate {
    
}
