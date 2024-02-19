//
//  HomeScreenView.swift
//  TripNN
//
//  Created by Pavel on 15.02.2024.
//

import UIKit

final class HomeScreenView: UIView, HSCycleGalleryViewDelegate {
    
    // MARK: - Closures
    
    var onOpeningSideMenuButtonAction: (() -> Void)?
    var onNewTripButtonAction: (() -> Void)?
    
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
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
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
        label.textColor = .tripnnDark
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
    
    let recommendationsCarouselView: UIView = {
        let view = UIView()
        return view
    }()
    
    let recommendationsCarouselCycleGallery: HSCycleGalleryView = {
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
    
    let newTripButton: UIButton = {
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
        setupConstrains()
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
        
        newTripView.addSubview(newTripButton)
        
        setupStacks()
        setupCycleGalleryView()
    }
    
    private func setupStacks() {
        infoPartStack.addArrangedSubview(recommendationsHeaderStack)
        infoPartStack.addArrangedSubview(recommendationsCarouselView)
        infoPartStack.addArrangedSubview(allPlaceButton)
        
        recommendationsHeaderStack.addArrangedSubview(recommendationsLabel)
        recommendationsHeaderStack.addArrangedSubview(allRecommendationsButton)
        
        newTripLabelStack.addArrangedSubview(newTripFirstLineLabelPartView)
        newTripLabelStack.addArrangedSubview(newTripSecondLineLabelPartView)
    }
    
    private func setupCycleGalleryView() {
        recommendationsCarouselCycleGallery.register(cellClass: ItemCardCell.self, forCellReuseIdentifier: "cell")
        recommendationsCarouselCycleGallery.delegate = self
        recommendationsCarouselView.addSubview(recommendationsCarouselCycleGallery)
        recommendationsCarouselCycleGallery.reloadData()
    }
    
    // MARK: - Actions
    
    private func addActions() {
        openingSideMenuButton.addTarget(self, action: #selector(openSideMenu), for: .touchUpInside)
        newTripButton.addTarget(self, action: #selector(createNewTrip), for: .touchUpInside)
    }
    
    @objc private func openSideMenu() {
        onOpeningSideMenuButtonAction?()
    }
    
    @objc private func createNewTrip() {
        onNewTripButtonAction?()
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
        setupRecommendationsCarouselViewConstraints()
        setupAllRecommendationsButtonConstraints()
        setupNewTripButtonConstraints()
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
            logoImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            logoImage.heightAnchor.constraint(equalToConstant: 28.6)
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
            infoPartStack.bottomAnchor.constraint(equalTo: infoPartView.bottomAnchor, constant: -25),
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
    
    private func setupAllRecommendationsButtonConstraints() {
        allRecommendationsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            allRecommendationsButton.heightAnchor.constraint(equalTo: recommendationsLabel.heightAnchor)
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
    
    private func setupNewTripButtonConstraints() {
        newTripButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            newTripButton.centerXAnchor.constraint(equalTo: tripPartView.centerXAnchor),
            newTripButton.centerYAnchor.constraint(equalTo: tripPartView.centerYAnchor),
            newTripButton.widthAnchor.constraint(equalToConstant: self.bounds.width/2.5+100),
            newTripButton.heightAnchor.constraint(equalToConstant: self.bounds.width/2.5)
        ])
    }
    
    private func setupRecommendationsCarouselViewConstraints() {
        recommendationsCarouselView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            recommendationsCarouselView.leadingAnchor.constraint(equalTo: leadingAnchor),
            recommendationsCarouselView.trailingAnchor.constraint(equalTo: trailingAnchor),
            recommendationsCarouselView.heightAnchor.constraint(equalToConstant: 155),
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
        
        guard let cell = cell as? ItemCardCell else {
            return UICollectionViewCell()
        }
        
        configCell(for: cell)
        return cell
    }
    
    func configCell(for cell: ItemCardCell) {
        cell.configure(cardModel: ItemCardModel(image: UIImage(named: "place_1")!, type: .route, title: "Историческая часть города", costInfo: "0 – 500₽"))
    }

}
