//
//  HomeScreenView.swift
//  TripNN
//
//  Created by Pavel on 15.02.2024.
//

import UIKit

final class HomeScreenView: UIView {
    
    // MARK: - Closures
    
    var onOpeningSideMenuButtonAction: (() -> Void)?
    
    // MARK: - Views
    
    let infoPartView: UIView = {
        let view = UIView()
        view.backgroundColor = .tripnnYellow
        return view
    }()
    
    let tripPartView: UIView = {
        let view = UIView()
        view.backgroundColor = .tripnnWhite
        return view
    }()
    
    let logoImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "logo-dark-icon"))
        return image
    }()
    
    let openingSideMenuButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "side-menu-icon"), for: .normal)
        return button
    }()
    
    let infoPartStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 22
        stack.axis = .vertical
        stack.alignment = .center
        return stack
    }()
    
    let recommendationsHeaderStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .center
        
        return stack
    }()
    
    let recommendationsLabel: UILabel = {
        let label = UILabel()
        label.text = "Рекомендованные маршруты"
        label.font =  UIFont(name: "Montserrat-Medium", size: 16)
        return label
    }()
    
    let allRecommendationsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Все", for: .normal)
        button.titleLabel?.font =  UIFont(name: "Montserrat-Regular", size: 14)
        button.layer.masksToBounds = false
        button.setTitleColor(.tripnnDark, for: .normal)
        return button
    }()
    
    let itemCardView: ItemCard = {
        let card = ItemCard()
        return card
    }()
    
    let allPlaceButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "all-place-icon"), for: .normal)
        button.setTitle("Все места Нижнего Новгорода", for: .normal)
        button.titleLabel?.font =  UIFont(name: "Montserrat-Regular", size: 14)
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 6
        button.setTitleColor(.tripnnDark, for: .normal)
        button.backgroundColor = .tripnnWhite
        button.addViewShadow()
        button.setInsets(forContentPadding: UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 13), imageTitlePadding: 13)
        return button
    }()
    
    let newTripView: UIView = {
        let view = UIView()
        return view
    }()
    
    let newTripBackgroundCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = .tripNNYellow
        view.addViewShadow()
        view.layer.masksToBounds = false
        return view
    }()
    
    let newTripLabelStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    
    let newTripFirstLineLabelPartView: UILabel = {
        let label = UILabel()
        label.text = "НОВЫЙ"
        label.font =  UIFont(name: "Montserrat-Black", size: 40)
        label.textColor = .tripnnDark
        return label
    }()
    
    let newTripSecondLineLabelPartView: UILabel = {
        let label = UILabel()
        label.text = "МАРШРУТ"
        label.font =  UIFont(name: "Montserrat-Black", size: 40)
        label.textColor = .tripnnDark
        return label
    }()
    
    let newTripSublabelView: UILabel = {
        let label = UILabel()
        label.text = "создать"
        label.font =  UIFont(name: "Montserrat-Regular", size: 12)
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
    
    // MARK: - Setup
    
    private func setup() {
        setupViews()
        setupConstrains()
        setupViewContent()
        addActions()
    }
    
    // MARK: - View Hierarchy
    
    private func setupViews() {
        self.addSubview(infoPartView)
        self.addSubview(tripPartView)
        
        infoPartView.addSubview(logoImage)
        infoPartView.addSubview(openingSideMenuButton)
        infoPartView.addSubview(infoPartStack)
        
        tripPartView.addSubview(newTripView)
        newTripView.addSubview(newTripBackgroundCircleView)
        
        newTripView.addSubview(newTripLabelStack)
        newTripView.addSubview(newTripSublabelView)
        
        setupStacks()
    }
    
    private func setupViewContent() {
        itemCardView.configure(cardModel: ItemCardModel(image: UIImage(named: "place_1")!, type: .route, title: "Историческая часть города", costInfo: "0 – 500₽"))
    }
    
    private func setupStacks() {
        infoPartStack.addArrangedSubview(recommendationsHeaderStack)
        infoPartStack.addArrangedSubview(itemCardView)
        infoPartStack.addArrangedSubview(allPlaceButton)
        
        recommendationsHeaderStack.addArrangedSubview(recommendationsLabel)
        recommendationsHeaderStack.addArrangedSubview(allRecommendationsButton)
        
        newTripLabelStack.addArrangedSubview(newTripFirstLineLabelPartView)
        newTripLabelStack.addArrangedSubview(newTripSecondLineLabelPartView)
    }
    
    // MARK: - Actions
    
    private func addActions() {
        openingSideMenuButton.addTarget(self, action: #selector(openSideMenu), for: .touchUpInside)
    }

    @objc private func openSideMenu() {
        onOpeningSideMenuButtonAction?()
    }
    
    // MARK: - Constraints
    
    private func setupConstrains() {
        setupInfoPartViewConstraints()
        setupTripPartViewConstraints()
        setupLogoImageConstraints()
        setupOpeningSideMenuButtonConstraints()
        setupInfoPartStackConstraints()
        setupAllPlaceButtonConstraints()
        setupRecommendationsHeaderStackConstraints()
        setupNewTripViewConstraints()
        setupNewTripBackgroundCircleViewConstraints()
        setupNewTripLabelStackConstraints()
        setupNewTripSublabelViewConstraints()
        setupItemCardViewConstraints()
    }
    
    private func setupInfoPartViewConstraints() {
        infoPartView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            infoPartView.topAnchor.constraint(equalTo: self.topAnchor),
            infoPartView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            infoPartView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            infoPartView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.frame.height / 2)
        ])
    }
    
    private func setupTripPartViewConstraints() {
        tripPartView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            tripPartView.topAnchor.constraint(equalTo: infoPartView.bottomAnchor),
            tripPartView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tripPartView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tripPartView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setupLogoImageConstraints() {
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            logoImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }
    
    private func setupOpeningSideMenuButtonConstraints() {
        openingSideMenuButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            openingSideMenuButton.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor),
            openingSideMenuButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            openingSideMenuButton.widthAnchor.constraint(equalToConstant: 44),
            openingSideMenuButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupInfoPartStackConstraints() {
        infoPartStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            infoPartStack.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 25),
            infoPartStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            infoPartStack.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func setupRecommendationsHeaderStackConstraints() {
        recommendationsHeaderStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            recommendationsHeaderStack.topAnchor.constraint(equalTo: infoPartStack.topAnchor, constant: 0),
            recommendationsHeaderStack.leadingAnchor.constraint(equalTo: infoPartStack.leadingAnchor, constant: 16),
            recommendationsHeaderStack.trailingAnchor.constraint(equalTo: infoPartStack.trailingAnchor, constant: -16),
        ])
    }
    
    private func setupAllPlaceButtonConstraints() {
        allPlaceButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            allPlaceButton.leadingAnchor.constraint(equalTo: infoPartStack.leadingAnchor, constant: 16),
            allPlaceButton.trailingAnchor.constraint(equalTo: infoPartStack.trailingAnchor, constant: -16),
            allPlaceButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupNewTripViewConstraints() {
        newTripView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            newTripView.centerXAnchor.constraint(equalTo: tripPartView.centerXAnchor),
            newTripView.centerYAnchor.constraint(equalTo: tripPartView.centerYAnchor),
            newTripView.widthAnchor.constraint(equalToConstant: self.bounds.width/2.5),
            newTripView.heightAnchor.constraint(equalToConstant: self.bounds.width/2.5)
        ])
    }
    
    private func setupNewTripBackgroundCircleViewConstraints() {
        newTripBackgroundCircleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            newTripBackgroundCircleView.centerXAnchor.constraint(equalTo: newTripView.centerXAnchor),
            newTripBackgroundCircleView.centerYAnchor.constraint(equalTo: newTripView.centerYAnchor),
            newTripBackgroundCircleView.widthAnchor.constraint(equalToConstant: self.bounds.width/2.5),
            newTripBackgroundCircleView.heightAnchor.constraint(equalToConstant: self.bounds.width/2.5)
        ])
        newTripBackgroundCircleView.layer.cornerRadius = self.bounds.width/5
    }
    
    private func setupNewTripLabelStackConstraints() {
        newTripLabelStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            newTripLabelStack.centerXAnchor.constraint(equalTo: newTripView.centerXAnchor),
            newTripLabelStack.centerYAnchor.constraint(equalTo: newTripView.centerYAnchor),
            newTripLabelStack.heightAnchor.constraint(equalToConstant: self.bounds.width/2.5)
        ])
        newTripLabelStack.spacing = -self.bounds.width/4.5
    }
    
    private func setupNewTripSublabelViewConstraints() {
        newTripSublabelView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            newTripSublabelView.centerXAnchor.constraint(equalTo: tripPartView.centerXAnchor),
            newTripSublabelView.topAnchor.constraint(equalTo: newTripSecondLineLabelPartView.topAnchor, constant: self.bounds.width/5),
        ])
    }
    
    private func setupItemCardViewConstraints() {
        itemCardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            itemCardView.widthAnchor.constraint(equalToConstant: self.bounds.width - 56),
            itemCardView.heightAnchor.constraint(equalToConstant: 132)
        ])
    }
    
}
