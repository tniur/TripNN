//
//  FindPlacesMenuView.swift
//  TripNN
//
//  Created by Pavel on 11.03.2024.
//

import UIKit

final class FindPlacesMenuView: UIView {
    
    // MARK: - Closures
    
    var onNextStepButtonAction: (() -> Void)?
    
    // MARK: - Properties
    
    private let segmentedControlItems = [String(localized: "culture"), String(localized: "leisure"), String(localized: "food")]
    
    private let collectionViewData = ["Кафе", "Рестораны", "Бары", "Пиццерии", "Быстрое питание", "Кофейни","Столовые","Суши-бары","Рюмочные", "Кондитерские изделия", "Пекарни","Кафе-кондитерские"]

    // MARK: - View
    
    lazy var placesSegmentedControl = SegmentedControl(items: segmentedControlItems)
    
    private lazy var tagCollectionView =  UICollectionView(frame: .zero, collectionViewLayout: makeLeftLayout())
    
    private func makeLeftLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, env in
            let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(56))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.contentInsets = .init(top: 12, leading: 0, bottom: 0, trailing: 0)
            group.interItemSpacing = .fixed(12)

            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
    
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
        self.backgroundColor = .white
        setupView()
        setupConstraints()
        
        tagCollectionView.register(PlaceTagCollectionViewCell.self, forCellWithReuseIdentifier: "PlaceTagCell")
        self.addSubview(tagCollectionView)
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        
        tagCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tagCollectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tagCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tagCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tagCollectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupView() {
        self.addSubview(placesSegmentedControl)
    }
    
    private func setupConstraints() {
        setupPlacesSegmentedControlConstraints()
    }
    
    // MARK: - Constraints
    
    private func setupPlacesSegmentedControlConstraints() {
        placesSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placesSegmentedControl.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            placesSegmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            placesSegmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
}

extension FindPlacesMenuView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceTagCell", for: indexPath) as! PlaceTagCollectionViewCell
        cell.configure(title: collectionViewData[indexPath.row])
        return cell
    }
}
