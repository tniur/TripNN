//
//  ItemCardCollectionViewCell.swift
//  TripNN
//
//  Created by Pavel on 15.02.2024.
//

import UIKit

final class ItemCardCollectionViewCell: UICollectionViewCell {
    
    // MARK: - View
    
    private let itemCardView = ItemCardTemplateView()

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Сonfigure
    
    func configure(cardModel: ItemCardModel) {
        itemCardView.configure(cardModel: cardModel)
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        contentView.addSubview(itemCardView)
    }
    
    private func setupConstraints() {
        itemCardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemCardView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            itemCardView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            itemCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemCardView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
        ])
    }
}
