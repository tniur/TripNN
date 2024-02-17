//
//  ItemCard.swift
//  TripNN
//
//  Created by Pavel on 15.02.2024.
//

import UIKit

final class ItemCard: UIView {
    
    // MARK: - Views
    
    let cardStack: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .tripnnWhite
        stack.layer.masksToBounds = false
        stack.layer.cornerRadius = 6
        stack.spacing = 12
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    
    let cardImage: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = false
        image.layer.cornerRadius = 6
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let infoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .equalCentering
        return stack
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont(name: "Montserrat-Regular", size: 10)
        label.textColor = .tripnnDark
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont(name: "Montserrat-Regular", size: 16)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        label.textColor = .tripnnDark
        return label
    }()
    
    let costStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 6
        return stack
    }()
    
    let costIconImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "wallet-icon"))
        return image
    }()
    
    let costLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont(name: "Montserrat-Medium", size: 9)
        label.textColor = .tripnnDark
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Configure
    
    func configure(cardModel: ItemCardModel) {
        titleLabel.text = cardModel.title
        cardImage.image = cardModel.image
        costLabel.text = cardModel.costInfo
        
        switch cardModel.type {
        case .route:
            typeLabel.text = "Маршрут"
        case .place:
            typeLabel.text = "Место"
        }
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupViews()
        setupConstrains()
        addViewShadow()
    }
    
    private func setupViews() {
        addSubview(cardStack)
        setupStacks()
    }
    
    private func setupStacks() {
        cardStack.addArrangedSubview(cardImage)
        cardStack.addArrangedSubview(infoStack)
        infoStack.addArrangedSubview(typeLabel)
        infoStack.addArrangedSubview(titleLabel)
        infoStack.addArrangedSubview(costStack)
        costStack.addArrangedSubview(costIconImage)
        costStack.addArrangedSubview(costLabel)
    }
    
    // MARK: - Constrains
    
    private func setupConstrains() {
        setupCardStackConstrains()
        setupInfoStackConstrains()
    }
    
    private func setupCardStackConstrains() {
        cardStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardStack.heightAnchor.constraint(equalTo: heightAnchor),
            cardStack.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    private func setupInfoStackConstrains() {
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoStack.topAnchor.constraint(equalTo: cardStack.topAnchor, constant: 9),
            infoStack.bottomAnchor.constraint(equalTo: cardStack.bottomAnchor, constant: -9),
        ])
    }
    
}
