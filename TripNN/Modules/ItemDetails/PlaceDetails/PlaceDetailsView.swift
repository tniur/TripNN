//
//  PlaceDetailsView.swift
//  TripNN
//
//  Created by Pavel on 23.02.2024.
//

import UIKit

final class PlaceDetailsView: UIView {
    
    // MARK: - Closures
    
    var onDismissAction: (() -> Void)?
    var onOpenFullScreenImageAction: (() -> Void)?
    
    // MARK: - Constants
    
    let placeImages = [UIImage(named: "place_1"), UIImage(named: "place_2"), UIImage(named: "place_3"), UIImage(named: "place_4"), UIImage(named: "place_5")]
    
    var currentImageIndex: Int = 0
    
    // MARK: - View
    
    private let placeImagesCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 195, height: 135)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .tripnnWhite
        
        return collection
    }()
    
    private let titleLabel = Title(text: "Вспышка", font: .semiBold, size: 24)
    
    private let favouriteButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "add-favorites-icon")
        button.setImage(buttonImage, for: .normal)
        return button
    }()
    
    private let placeInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let mapLinkStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 4
        return stack
    }()
    
    private let generalInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private let detailsInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 12
        
        return stack
    }()
    
    private let titleAndTypeInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 7
        
        return stack
    }()
    
    private let mapLinkAndRatingInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 8
        return stack
    }()
    
    private let ratingInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private let addressStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private let addressCopyButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "copy-icon")
        button.setImage(buttonImage, for: .normal)
        return button
    }()
    
    private let mapLinkLabel = Title(text: "2GIS", font: .regular, size: 13)
    
    private let mapLinkButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "link-icon")
        button.setImage(buttonImage, for: .normal)
        return button
    }()
    
    private let typeLabel = Title(text: "Пышечная", font: .regular, size: 13)
    
    private let addressLabel = Title(text: "Алексеевская, 11", font: .regular, size: 11)
    
    private let workingHoursLabel = Title(text: "Ежедневно с 10:00 до 21:00", font: .regular, size: 11)
    
    private let contactsLabel = Title(text: "+7-963-231-96-17", font: .regular, size: 11)
    
    private let averageCheckLabel = Title(text: "Средний чек 200 ₽", font: .regular, size: 11)
    
    private let ratingValueLabel: UILabel = {
        let label = Title(text: "4.5", font: .bold, size: 12)
        
        if let rating = Float(label.text ?? "0") {
            switch rating {
            case 0:
                label.textColor = .tripnnDark
            case ..<3:
                label.textColor = .tripnnRed
            case ..<4:
                label.textColor = .tripnnOrange
            case 4...:
                label.textColor = .tripnnGreen
            default:
                label.textColor = .tripnnDark
            }
        }
        
        return label
    }()
    
    private let numberOfRatingsLabel = Title(text: "199 оценок", font: .regular, size: 12)
    
    private let  clipboardSavingNotification: ClipboardSavingNotification = {
        let notification = ClipboardSavingNotification()
        return notification
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
        setupView()
        setupConstrains()
        setupStack()
        setupCollectionView()
        setupActions()
    }
    
    private func setupView() {
        self.backgroundColor = .tripnnWhite
        self.addSubview(placeInfoStack)
        self.addSubview(placeImagesCollection)
        self.addSubview(titleLabel)
        self.addSubview(favouriteButton)
        self.addSubview(clipboardSavingNotification)
        
        clipboardSavingNotification.isHidden = true
    }
    
    private func setupStack() {
        placeInfoStack.addArrangedSubview(generalInfoStack)
        placeInfoStack.addArrangedSubview(detailsInfoStack)
        
        generalInfoStack.addArrangedSubview(titleAndTypeInfoStack)
        generalInfoStack.addArrangedSubview(mapLinkAndRatingInfoStack)
        
        titleAndTypeInfoStack.addArrangedSubview(typeLabel)
        
        mapLinkAndRatingInfoStack.addArrangedSubview(mapLinkStack)
        mapLinkAndRatingInfoStack.addArrangedSubview(ratingInfoStack)
        
        mapLinkStack.addArrangedSubview(mapLinkLabel)
        mapLinkStack.addArrangedSubview(mapLinkButton)
        
        ratingInfoStack.addArrangedSubview(ratingValueLabel)
        ratingInfoStack.addArrangedSubview(numberOfRatingsLabel)
        
        detailsInfoStack.addArrangedSubview(addressStack)
        detailsInfoStack.addArrangedSubview(addressLabel)
        detailsInfoStack.addArrangedSubview(workingHoursLabel)
        detailsInfoStack.addArrangedSubview(contactsLabel)
        detailsInfoStack.addArrangedSubview(averageCheckLabel)
        
        addressStack.addArrangedSubview(addressLabel)
        addressStack.addArrangedSubview(addressCopyButton)
    }
    
    private func setupConstrains() {
        setupPlaceInfoStackConstrains()
        setupTitleLabelConstrains()
        setupPlaceImagesCollectionConstrains()
        setupFavouriteButtonConstrains()
        setupClipboardSavingNotificationConstrains()
    }
    
    private func setupCollectionView() {
        placeImagesCollection.register(PlaceDetailsCollectionViewCell.self, forCellWithReuseIdentifier: "PlaceDetailsCell")
        placeImagesCollection.dataSource = self
        placeImagesCollection.delegate = self
    }
    
    private func setupActions() {
        addressCopyButton.addTarget(self, action: #selector(copyButtonAction), for: .touchUpInside)
        mapLinkButton.addTarget(self, action: #selector(mapLinkAction), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func copyButtonAction() {
        UIPasteboard.general.string = addressLabel.text
        showClipboardSavingNotification()
    }
    
    @objc private func mapLinkAction() {
        if let url = URL(string: "https://www.youtube.com/") {
            UIApplication.shared.open(url)
        }
    }
    
    private func showClipboardSavingNotification() {
        addressCopyButton.isEnabled = false
        clipboardSavingNotification.alpha = 1
        clipboardSavingNotification.isHidden = false
        
        UIView.animate(withDuration: 1, delay: 1, options: UIView.AnimationOptions.transitionFlipFromTop, animations: {
            self.clipboardSavingNotification.alpha = 0
        }, completion: { finished in
            self.clipboardSavingNotification.isHidden = true
            self.addressCopyButton.isEnabled = true
        })
    }
    
    // MARK: - Constrains
    
    private func setupPlaceImagesCollectionConstrains() {
        placeImagesCollection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeImagesCollection.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            placeImagesCollection.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            placeImagesCollection.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            placeImagesCollection.heightAnchor.constraint(equalToConstant: 135)
        ])
    }
    
    private func setupTitleLabelConstrains() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: placeImagesCollection.bottomAnchor, constant: 17),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
    }
    
    private func setupFavouriteButtonConstrains() {
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favouriteButton.heightAnchor.constraint(equalToConstant: 30),
            favouriteButton.widthAnchor.constraint(equalToConstant: 30),
            favouriteButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            favouriteButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10)
        ])
    }
    
    private func setupPlaceInfoStackConstrains() {
        placeInfoStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeInfoStack.topAnchor.constraint(equalTo: favouriteButton.bottomAnchor, constant: 10),
            placeInfoStack.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            placeInfoStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            placeInfoStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    private func setupClipboardSavingNotificationConstrains() {
        clipboardSavingNotification.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            clipboardSavingNotification.bottomAnchor.constraint(equalTo: placeInfoStack.bottomAnchor),
            clipboardSavingNotification.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            clipboardSavingNotification.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
}

extension PlaceDetailsView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        placeImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceDetailsCell", for: indexPath) as? PlaceDetailsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(image: placeImages[indexPath.row]!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentImageIndex = indexPath.row
        onOpenFullScreenImageAction?()
    }
}
