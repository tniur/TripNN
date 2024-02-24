//
//  HomeScreenView.swift
//  TripNN
//
//  Created by Pavel on 15.02.2024.
//

import UIKit

final class HomeScreenView: UIView, HSCycleGalleryViewDelegate {
    
    // MARK: - Closures
    
    var onSideMenuButtonAction: (() -> Void)?
    var onNewRouteButtonAction: (() -> Void)?
    var onAllPreparedRoutesButtonAction: (() -> Void)?
    
    // MARK: - Views
    
    let infoPartView: UIView = {
        let view = UIView()
        view.backgroundColor = .tripnnYellow
        return view
    }()
    
    let routePartView: UIView = {
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
    
    let infoPartStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()
    
    let preparedRoutesHeaderStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .center
        
        return stack
    }()
    
    let preparedRoutesLabel: UILabel = {
        let label = UILabel()
        label.text = "Готовые маршруты"
        label.textColor = .tripnnDark
        label.font =  UIFont(name: "Montserrat-SemiBold", size: 18)
        return label
    }()
    
    let allPreparedRoutesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Все", for: .normal)
        button.titleLabel?.font =  UIFont(name: "Montserrat-Regular", size: 14)
        button.layer.masksToBounds = false
        button.setTitleColor(.tripnnDark, for: .normal)
        return button
    }()
    
    private let cycleGalleryViewContent: [ItemCardModel] = [
        ItemCardModel(image: UIImage(named: "place_1")!, type: .route, title: "Историческая часть города", costInfo: "0 – 500₽"),
        ItemCardModel(image: UIImage(named: "place_2")!, type: .route, title: "Большая Покровская улица", costInfo: "0₽"),
        ItemCardModel(image: UIImage(named: "place_3")!, type: .route, title: "Улица Рождественская", costInfo: "0₽")
    ]
    
    let preparedRoutesCarouselView: UIView = {
        let view = UIView()
        return view
    }()
    
    let preparedRoutesCarouselCycleGallery: HSCycleGalleryView = {
        let gallery = HSCycleGalleryView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 155))
        gallery.contentBackgroundColor = .tripnnYellow
        return gallery
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
    
    let newRouteView: UIView = {
        let view = UIView()
        return view
    }()
    
    let newRouteBackgroundCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = .tripNNYellow
        view.addViewShadow()
        view.layer.masksToBounds = false
        return view
    }()
    
    let newRouteLabelStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    
    let newRouteFirstRowLabel: UILabel = {
        let label = UILabel()
        label.text = "новый".uppercased()
        label.font =  UIFont(name: "Montserrat-Black", size: 40)
        label.textColor = .tripnnDark
        return label
    }()
    
    let newRouteSecondRowLabel: UILabel = {
        let label = UILabel()
        label.text = "маршрут".uppercased()
        label.font =  UIFont(name: "Montserrat-Black", size: 40)
        label.textColor = .tripnnDark
        return label
    }()
    
    let newRouteSublabel: UILabel = {
        let label = UILabel()
        label.text = "создать"
        label.font =  UIFont(name: "Montserrat-Regular", size: 12)
        label.textColor = .tripnnDark
        return label
    }()
    
    let newRouteButton: UIButton = {
        let button = UIButton()
        return button
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
        setupStacks()
        setupCycleGalleryView()
        setupConstrains()
        addActions()
    }
    
    // MARK: - View Hierarchy
    
    private func setupViews() {
        self.addSubview(infoPartView)
        self.addSubview(routePartView)
        
        infoPartView.addSubview(logoImage)
        infoPartView.addSubview(sideMenuButton)
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
        sideMenuButton.addTarget(self, action: #selector(openSideMenu), for: .touchUpInside)
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
        setupLogoImageConstraints()
        setupSideMenuButtonConstraints()
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
    
    private func setupLogoImageConstraints() {
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            logoImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            logoImage.heightAnchor.constraint(equalToConstant: 28.6)
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
    
    private func setupInfoPartStackConstraints() {
        infoPartStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            infoPartStack.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 25),
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

extension HomeScreenView {
    
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
