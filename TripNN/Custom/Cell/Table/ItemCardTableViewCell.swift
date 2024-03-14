//
//  ItemCardTableViewCell.swift
//  TripNN
//
//  Created by Pavel on 15.02.2024.
//

import UIKit

final class ItemCardTableViewCell: UITableViewCell {
    
    // MARK: - View
    
    private let containerView = UIView()
    
    private let itemCardView = ItemCardTemplateView()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setup() {
        containerView.addSubview(itemCardView)
        contentView.addSubview(containerView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = containerView.heightAnchor.constraint(equalToConstant: 155)
        heightConstraint.priority = UILayoutPriority(999)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            heightConstraint
        ])
        
        itemCardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemCardView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            itemCardView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            itemCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14),
            itemCardView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 14),
        ])
        
    }
    
    func configure(cardModel: ItemCardModel) { 
        itemCardView.configure(cardModel: cardModel)
    }
}
