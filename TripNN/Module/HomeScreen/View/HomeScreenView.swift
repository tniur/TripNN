//
//  HomeScreenView.swift
//  TripNN
//
//  Created by Pavel on 15.02.2024.
//

import UIKit

final class HomeScreenView: UIView {
    
    // MARK: - Closures
    
    var onSideMenuAction: (() -> Void)?
    
    // MARK: - Views
    
    let topPartView: UIView = {
        let view = UIView()
        view.backgroundColor = .tripnnYellow
        return view
    }()
    
    let bottomPartView: UIView = {
        let view = UIView()
        view.backgroundColor = .tripnnWhite
        return view
    }()
    
    let logoImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "logo-dark-icon"))
        return image
    }()
    
    let sideMenuButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "side-menu-icon"), for: .normal)
        return button
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
    
    let topPartStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 22
        stack.axis = .vertical
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
    
    let recommendationsHeaderStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .center
        
        return stack
    }()
    
    let newTripView: UIView = {
        let view = UIView()
        return view
    }()
    
    let newTripCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = .tripNNYellow
        view.addViewShadow()
        view.layer.masksToBounds = false
        return view
    }()
    
    let newTripTopLabelPartView: UILabel = {
        let label = UILabel()
        label.text = "НОВЫЙ"
        label.font =  UIFont(name: "Montserrat-Black", size: 40)
        label.textColor = .tripnnDark
        return label
    }()
    
    let newTripBottomLabelPartView: UILabel = {
        let label = UILabel()
        label.text = "МАРШРУТ"
        label.font =  UIFont(name: "Montserrat-Black", size: 40)
        label.textColor = .tripnnDark
        return label
    }()

    let newTripLabelStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    
    let newTripSublabelView: UILabel = {
        let label = UILabel()
        label.text = "создать"
        label.font =  UIFont(name: "Montserrat-Regular", size: 12)
        label.textColor = .tripnnDark
        return label
    }()
    
    let placeCardView: ItemCard = {
        let card = ItemCard()
        return card
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
        self.addSubview(topPartView)
        self.addSubview(bottomPartView)
        topPartView.addSubview(logoImage)
        topPartView.addSubview(sideMenuButton)
        topPartView.addSubview(topPartStack)
        
        bottomPartView.addSubview(newTripView)
        newTripView.addSubview(newTripCircleView)
        
        newTripView.addSubview(newTripLabelStack)
        newTripView.addSubview(newTripSublabelView)
        
        setupStacks()
    }
    
    private func setupViewContent() {
        placeCardView.configure(image: UIImage(named: "place_1")!, type: "Маршруты", title: "Историческая часть города", costInfo: "0 – 500₽")
    }
    
    private func setupStacks() {
        topPartStack.addArrangedSubview(recommendationsHeaderStack)
        topPartStack.addArrangedSubview(placeCardView)
        topPartStack.addArrangedSubview(allPlaceButton)
        
        recommendationsHeaderStack.addArrangedSubview(recommendationsLabel)
        recommendationsHeaderStack.addArrangedSubview(allRecommendationsButton)
        
        newTripLabelStack.addArrangedSubview(newTripTopLabelPartView)
        newTripLabelStack.addArrangedSubview(newTripBottomLabelPartView)
    }
    
    // MARK: - Constraints
    
    private func setupConstrains() {
        setupTopPartViewConstraints()
        setupBottomPartViewConstraints()
        setupLogoImageConstraints()
        setupSideMenuButtonConstraints()
        setupTopPartStackConstraints()
        setupAllPlaceButtonConstraints()
        setupRecommendationsHeaderStackConstraints()
        setupNewTripViewConstraints()
        setupNewTripCircleViewConstraints()
        setupNewTripLabelStackConstraints()
        setupNewTripSublabelViewConstraints()
        setupPlaceCardViewConstraints()
    }
    
    private func setupTopPartViewConstraints() {
        topPartView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            topPartView.topAnchor.constraint(equalTo: self.topAnchor),
            topPartView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topPartView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topPartView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.frame.height / 2)
        ])
    }
    
    private func setupBottomPartViewConstraints() {
        bottomPartView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            bottomPartView.topAnchor.constraint(equalTo: topPartView.bottomAnchor),
            bottomPartView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomPartView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomPartView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setupLogoImageConstraints() {
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            logoImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }
    
    private func setupSideMenuButtonConstraints() {
        sideMenuButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            sideMenuButton.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor),
            sideMenuButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            sideMenuButton.widthAnchor.constraint(equalToConstant: 44),
            sideMenuButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupTopPartStackConstraints() {
        topPartStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            topPartStack.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 25),
            topPartStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topPartStack.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func setupRecommendationsHeaderStackConstraints() {
        recommendationsHeaderStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            recommendationsHeaderStack.topAnchor.constraint(equalTo: topPartStack.topAnchor, constant: 0),
            recommendationsHeaderStack.leadingAnchor.constraint(equalTo: topPartStack.leadingAnchor, constant: 16),
            recommendationsHeaderStack.trailingAnchor.constraint(equalTo: topPartStack.trailingAnchor, constant: -16),
        ])
    }
    
    private func setupAllPlaceButtonConstraints() {
        allPlaceButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            allPlaceButton.leadingAnchor.constraint(equalTo: topPartStack.leadingAnchor, constant: 16),
            allPlaceButton.trailingAnchor.constraint(equalTo: topPartStack.trailingAnchor, constant: -16),
            allPlaceButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupNewTripViewConstraints() {
        newTripView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            newTripView.centerXAnchor.constraint(equalTo: bottomPartView.centerXAnchor),
            newTripView.centerYAnchor.constraint(equalTo: bottomPartView.centerYAnchor),
            newTripView.widthAnchor.constraint(equalToConstant: self.bounds.width/2.5),
            newTripView.heightAnchor.constraint(equalToConstant: self.bounds.width/2.5)
        ])
    }
    
    private func setupNewTripCircleViewConstraints() {
        newTripCircleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            newTripCircleView.centerXAnchor.constraint(equalTo: newTripView.centerXAnchor),
            newTripCircleView.centerYAnchor.constraint(equalTo: newTripView.centerYAnchor),
            newTripCircleView.widthAnchor.constraint(equalToConstant: self.bounds.width/2.5),
            newTripCircleView.heightAnchor.constraint(equalToConstant: self.bounds.width/2.5)
        ])
        newTripCircleView.layer.cornerRadius = self.bounds.width/5
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
            newTripSublabelView.centerXAnchor.constraint(equalTo: bottomPartView.centerXAnchor),
            newTripSublabelView.topAnchor.constraint(equalTo: newTripBottomLabelPartView.topAnchor, constant: self.bounds.width/5),
        ])
    }
    
    private func setupPlaceCardViewConstraints() {
        placeCardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            placeCardView.widthAnchor.constraint(equalToConstant: self.bounds.width - 56),
            placeCardView.heightAnchor.constraint(equalToConstant: 132)
        ])
    }
    
    // MARK: - Actions
    
    private func addActions() {
        sideMenuButton.addTarget(self, action: #selector(sideMenuAction), for: .touchUpInside)
        // allRecommendationsButton.addTarget(self, action: #selector(allRecommendationsAction), for: .touchUpInside)
        // allPlaceButton.addTarget(self, action: #selector(allPlaceAction), for: .touchUpInside)
    }

    @objc private func sideMenuAction() {
        onSideMenuAction?()
    }
    
}
