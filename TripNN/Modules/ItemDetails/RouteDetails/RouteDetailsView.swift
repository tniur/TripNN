//
//  RouteDetailsView.swift
//  TripNN
//
//  Created by Pavel on 23.02.2024.
//

import UIKit

final class RouteDetailsView: UIView {
    
    // MARK: - Closures
    
    var onSelectTableCellAction: (() -> Void)?
    
    // MARK: - Constants
    
    private let PlacesTableViewContent: [ItemCardModel] = [
        ItemCardModel(image: UIImage(named: "route_1")!, type: .route, title: "Историческая часть города", costInfo: "0 – 500₽"),
        ItemCardModel(image: UIImage(named: "route_2")!, type: .route, title: "Большая Покровская улица", costInfo: "Бесплатно"),
        ItemCardModel(image: UIImage(named: "route_3")!, type: .route, title: "Улица Рождественская", costInfo: "Бесплатно"),
        ItemCardModel(image: UIImage(named: "route_4")!, type: .route, title: "Верхняя часть города", costInfo: "Бесплатно")
    ]
    
    // MARK: - Views
    
    private let tableView = UITableView()
    
    private let headerView = UIView()
    
    private let titleLabel: UILabel = {
        let label = Title(text: "Маршрут \"Историческая часть города\"", font: .semiBold, size: 20)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 3
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = Title(text: "Рекомендованное время начала не позднее 18:00", font: .regular, size: 12)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        return label
    }()
    
    private let favoritesButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "add-favorites"), for: .normal)
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .tripnnWhite
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupView()
        setupTableView()
        setupConstrains()
    }
    
    private func setupView() {
        self.addSubview(headerView)
        headerView.addSubview(titleLabel)
        headerView.addSubview(favoritesButton)
        headerView.addSubview(infoLabel)
        self.addSubview(tableView)
    }
    
    private func setupConstrains() {
        setupHeaderViewConstrains()
        setupSheetTitleLabelConstrains()
        setupFavoritesButtonConstrains()
        setupInfoLabelConstrains()
        setupTableViewConstraints()
    }
    
    private func setupTableView() {
        tableView.register(ItemCardTableViewCell.self, forCellReuseIdentifier: "ItemCardCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    // MARK: - Constraints
    
    private func setupHeaderViewConstrains() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 110)
        ])
    }
    
    private func setupSheetTitleLabelConstrains() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 14),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: headerView.trailingAnchor, constant: -14),
        ])
    }
    
    private func setupFavoritesButtonConstrains() {
        favoritesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoritesButton.heightAnchor.constraint(equalToConstant: 44),
            favoritesButton.widthAnchor.constraint(equalToConstant: 44),
            favoritesButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 12),
            favoritesButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            favoritesButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -8),
        ])
    }
    
    private func setupInfoLabelConstrains() {
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            infoLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 14),
            infoLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -14),
        ])
    }
    
    private func setupTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension RouteDetailsView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        PlacesTableViewContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCardCell", for: indexPath) as? ItemCardTableViewCell else { fatalError() }
        
        cell.configure(cardModel: PlacesTableViewContent[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelectTableCellAction?()
    }
}
