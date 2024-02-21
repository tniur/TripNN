//
//  ItemCardCell.swift
//  TripNN
//
//  Created by Pavel on 15.02.2024.
//

import UIKit

final class ItemCard: UIView {
    
    // MARK: - View
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .tripnnWhite
        view.addViewShadow()
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 6
        return view
    }()
    
    let cardStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }()
    
    private let cardImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        image.contentMode = .scaleToFill
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
        label.numberOfLines = 3
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
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        addSubview(containerView)
        containerView.addSubview(cardStack)
        cardStack.addArrangedSubview(cardImage)
        cardStack.addArrangedSubview(infoStack)
        infoStack.addArrangedSubview(typeLabel)
        infoStack.addArrangedSubview(titleLabel)
        infoStack.addArrangedSubview(costStack)
        costStack.addArrangedSubview(costIconImage)
        costStack.addArrangedSubview(costLabel)
    }
    
    private func setupConstraints() {
        setupContainerViewConstraints()
        setupCardStackConstraints()
        setupCardImageConstraints()
        setupInfoStackConstrains()
    }
    
    // MARK: - Constraints
    
    private func setupContainerViewConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let heightConstraint = containerView.heightAnchor.constraint(equalToConstant: 132)
        heightConstraint.priority = UILayoutPriority(999)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            heightConstraint,
            containerView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    private func setupCardStackConstraints() {
        cardStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            cardStack.topAnchor.constraint(equalTo: containerView.topAnchor),
            cardStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            cardStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
    }
    
    private func setupCardImageConstraints() {
        cardImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardImage.bottomAnchor.constraint(equalTo: cardStack.bottomAnchor),
            cardImage.topAnchor.constraint(equalTo: cardStack.topAnchor),
            cardImage.leadingAnchor.constraint(equalTo: cardStack.leadingAnchor),
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
