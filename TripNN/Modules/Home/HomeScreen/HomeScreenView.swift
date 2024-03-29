//
//  HomeScreenView.swift
//  TripNN
//
//  Created by Pavel on 15.02.2024.
//

import UIKit

final class HomeScreenView: UIView {
    
    // MARK: - Closures
    
    var onSideMenuButtonAction: (() -> Void)?
    var onNewRouteButtonAction: (() -> Void)?
    var onAllPreparedRoutesButtonAction: (() -> Void)?
    
    // MARK: - Views
    
    private let infoPartView: UIView = {
        let view = UIView()
        view.backgroundColor = .tripnnYellow
        return view
    }()
    
    private let routePartView: UIView = {
        let view = UIView()
        view.backgroundColor = .tripnnWhite
        return view
    }()
    
    private let infoPartStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private let preparedRoutesHeaderStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .center
        return stack
    }()
    
    private let preparedRoutesLabel = Title(text: String(localized: "prepared_routes"), font: .medium, size: 18)
    
    private let allPreparedRoutesButton: UIButton = {
        let button = UIButton()
        button.setTitle(String(localized: "all_prepared_routes"), for: .normal)
        button.titleLabel?.font =  UIFont(name: "Montserrat-Regular", size: 14)
        button.layer.masksToBounds = false
        button.setTitleColor(.tripnnDark, for: .normal)
        return button
    }()
    
    private let cycleGalleryViewContent: [ItemCardModel] = [
        ItemCardModel(image: UIImage(named: "route_1")!, type: .route, title: "Историческая часть города", costInfo: "0 – 500₽"),
        ItemCardModel(image: UIImage(named: "route_2")!, type: .route, title: "Большая Покровская улица", costInfo: "0₽"),
        ItemCardModel(image: UIImage(named: "route_3")!, type: .route, title: "Улица Рождественская", costInfo: "0₽")
    ]
    
    private let preparedRoutesCarouselView = UIView()
    
    private let preparedRoutesCarouselCycleGallery: HSCycleGalleryView = {
        let gallery = HSCycleGalleryView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 155))
        gallery.contentBackgroundColor = .tripnnYellow
        return gallery
    }()
    
    private let allPlaceButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "all-place-icon"), for: .normal)
        button.setTitle(String(localized: "all_place_button"), for: .normal)
        button.titleLabel?.font =  UIFont(name: "Montserrat-Regular", size: 14)
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 6
        button.setTitleColor(.tripnnDark, for: .normal)
        button.backgroundColor = .tripnnWhite
        button.addViewShadow()
        button.setInsets(forContentPadding: UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 13), imageTitlePadding: 13)
        return button
    }()
    
    private let newRouteView = UIView()
    
    private let newRouteBackgroundCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = .tripNNYellow
        view.addViewShadow()
        view.layer.masksToBounds = false
        return view
    }()
    
    private let newRouteLabelStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let newRouteFirstRowLabel = Title(text: String(localized: "create_new_route_first_label").uppercased(), font: .black, size: 40)
    
    private let newRouteSecondRowLabel = Title(text: String(localized: "create_new_route_second_label").uppercased(), font: .black, size: 40)
    
    private let newRouteSublabel = Title(text: String(localized: "create"), font: .regular, size: 12)
    
    private let newRouteButton = UIButton()
    
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
        setupStacks()
        setupCycleGalleryView()
        setupConstrains()
        addActions()
    }
    
    // MARK: - View Hierarchy
    
    private func setupViews() {
        self.addSubview(infoPartView)
        self.addSubview(routePartView)
        
        infoPartView.addSubview(infoPartStack)
        
        routePartView.addSubview(newRouteView)
        newRouteView.addSubview(newRouteBackgroundCircleView)
        
        newRouteView.addSubview(newRouteLabelStack)
        newRouteView.addSubview(newRouteSublabel)
        
        newRouteView.addSubview(newRouteButton)
    }
    
    private func setupStacks() {
        infoPartStack.addArrangedSubview(preparedRoutesHeaderStack)
        infoPartStack.addArrangedSubview(preparedRoutesCarouselView)
        infoPartStack.addArrangedSubview(allPlaceButton)
        
        preparedRoutesHeaderStack.addArrangedSubview(preparedRoutesLabel)
        preparedRoutesHeaderStack.addArrangedSubview(allPreparedRoutesButton)
        
        newRouteLabelStack.addArrangedSubview(newRouteFirstRowLabel)
        newRouteLabelStack.addArrangedSubview(newRouteSecondRowLabel)
    }
    
    private func setupCycleGalleryView() {
        preparedRoutesCarouselCycleGallery.register(cellClass: ItemCardCollectionViewCell.self, forCellReuseIdentifier: "cell")
        preparedRoutesCarouselCycleGallery.delegate = self
        preparedRoutesCarouselView.addSubview(preparedRoutesCarouselCycleGallery)
        preparedRoutesCarouselCycleGallery.reloadData()
    }
    
    // MARK: - Actions
    
    private func addActions() {
        newRouteButton.addTarget(self, action: #selector(createNewRoute), for: .touchUpInside)
        allPreparedRoutesButton.addTarget(self, action: #selector(openAllRecommendations), for: .touchUpInside)
    }
    
    @objc private func openSideMenu() {
        onSideMenuButtonAction?()
    }
    
    @objc private func createNewRoute() {
        onNewRouteButtonAction?()
    }
    
    @objc private func openAllRecommendations() {
        onAllPreparedRoutesButtonAction?()
    }
    
    // MARK: - Constraints
    
    private func setupConstrains() {
        setupInfoPartViewConstraints()
        setupRoutePartViewConstraints()
        setupInfoPartStackConstraints()
        setupAllPlaceButtonConstraints()
        setupPreparedRoutesHeaderStackConstraints()
        setupNewRouteViewConstraints()
        setupNewRouteBackgroundCircleViewConstraints()
        setupNewRouteLabelStackConstraints()
        setupNewRouteSublabelViewConstraints()
        setupPreparedRoutesCarouselViewConstraints()
        setupAllPreparedRoutesButtonConstraints()
        setupNewRouteButtonConstraints()
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
    
    private func setupRoutePartViewConstraints() {
        routePartView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            routePartView.topAnchor.constraint(equalTo: infoPartView.bottomAnchor),
            routePartView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            routePartView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            routePartView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setupInfoPartStackConstraints() {
        infoPartStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            infoPartStack.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            infoPartStack.bottomAnchor.constraint(equalTo: infoPartView.bottomAnchor, constant: -25),
            infoPartStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            infoPartStack.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func setupPreparedRoutesHeaderStackConstraints() {
        preparedRoutesHeaderStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            preparedRoutesHeaderStack.topAnchor.constraint(equalTo: infoPartStack.topAnchor, constant: 0),
            preparedRoutesHeaderStack.leadingAnchor.constraint(equalTo: infoPartStack.leadingAnchor, constant: 16),
            preparedRoutesHeaderStack.trailingAnchor.constraint(equalTo: infoPartStack.trailingAnchor, constant: -16),
        ])
    }
    
    private func setupAllPreparedRoutesButtonConstraints() {
        allPreparedRoutesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            allPreparedRoutesButton.heightAnchor.constraint(equalTo: preparedRoutesLabel.heightAnchor)
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
    
    private func setupNewRouteViewConstraints() {
        newRouteView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            newRouteView.centerXAnchor.constraint(equalTo: routePartView.centerXAnchor),
            newRouteView.centerYAnchor.constraint(equalTo: routePartView.centerYAnchor),
            newRouteView.widthAnchor.constraint(equalToConstant: self.bounds.width/2.5),
            newRouteView.heightAnchor.constraint(equalToConstant: self.bounds.width/2.5)
        ])
    }
    
    private func setupNewRouteBackgroundCircleViewConstraints() {
        newRouteBackgroundCircleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            newRouteBackgroundCircleView.centerXAnchor.constraint(equalTo: newRouteView.centerXAnchor),
            newRouteBackgroundCircleView.centerYAnchor.constraint(equalTo: newRouteView.centerYAnchor),
            newRouteBackgroundCircleView.widthAnchor.constraint(equalToConstant: self.bounds.width/2.5),
            newRouteBackgroundCircleView.heightAnchor.constraint(equalToConstant: self.bounds.width/2.5)
        ])
        newRouteBackgroundCircleView.layer.cornerRadius = self.bounds.width/5
    }
    
    private func setupNewRouteLabelStackConstraints() {
        newRouteLabelStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            newRouteLabelStack.centerXAnchor.constraint(equalTo: newRouteView.centerXAnchor),
            newRouteLabelStack.centerYAnchor.constraint(equalTo: newRouteView.centerYAnchor),
            newRouteLabelStack.heightAnchor.constraint(equalToConstant: self.bounds.width/2.5)
        ])
        newRouteLabelStack.spacing = -self.bounds.width/4.5
    }
    
    private func setupNewRouteSublabelViewConstraints() {
        newRouteSublabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            newRouteSublabel.centerXAnchor.constraint(equalTo: routePartView.centerXAnchor),
            newRouteSublabel.topAnchor.constraint(equalTo: newRouteSecondRowLabel.topAnchor, constant: self.bounds.width/5),
        ])
    }
    
    private func setupNewRouteButtonConstraints() {
        newRouteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            newRouteButton.centerXAnchor.constraint(equalTo: routePartView.centerXAnchor),
            newRouteButton.centerYAnchor.constraint(equalTo: routePartView.centerYAnchor),
            newRouteButton.widthAnchor.constraint(equalToConstant: self.bounds.width/2.5+100),
            newRouteButton.heightAnchor.constraint(equalToConstant: self.bounds.width/2.5)
        ])
    }
    
    private func setupPreparedRoutesCarouselViewConstraints() {
        preparedRoutesCarouselView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            preparedRoutesCarouselView.leadingAnchor.constraint(equalTo: leadingAnchor),
            preparedRoutesCarouselView.trailingAnchor.constraint(equalTo: trailingAnchor),
            preparedRoutesCarouselView.heightAnchor.constraint(equalToConstant: 155),
        ])
    }
}

// MARK: - Cycle Gallery Extensions

extension HomeScreenView: HSCycleGalleryViewDelegate {
    
    func numberOfItemInCycleGalleryView(_ cycleGalleryView: HSCycleGalleryView) -> Int {
        return 3
    }
    
    func cycleGalleryView(_ cycleGalleryView: HSCycleGalleryView, cellForItemAtIndex index: Int) -> UICollectionViewCell {
        let cell = cycleGalleryView.dequeueReusableCell(withIdentifier: "cell", for: IndexPath(item: index, section: 0))
        
        guard let cell = cell as? ItemCardCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        configCell(for: cell, withIndex: index)
        return cell
    }
    
    func configCell(for cell: ItemCardCollectionViewCell, withIndex index: Int) {
        cell.configure(cardModel: cycleGalleryViewContent[index])
    }

}
