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
    
    private let collectionViewData = ["Кафе", "Рестораны", "Бары", "Пиццерии", "Быстрое питание", "Кофейни","Столовые","Суши-бары","Рюмочные", "Кондитерские изделия", "Пекарни","Кафе-кондитерские", "Кафе", "Рестораны", "Бары", "Пиццерии", "Быстрое питание", "Кофейни","Столовые","Суши-бары","Рюмочные", "Кондитерские изделия", "Пекарни","Кафе-кондитерские", "Кафе", "Рестораны", "Бары", "Пиццерии", "Быстрое питание", "Кофейни","Столовые","Суши-бары","Рюмочные", "Кондитерские изделия", "Пекарни","Кафе-кондитерские"]
    
    // MARK: - View
    
    private lazy var placesSegmentedControl = SegmentedControl(items: segmentedControlItems)
    
    private lazy var tagsCollectionView =  UICollectionView(frame: .zero, collectionViewLayout: makeLeftLayout())
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Func
    
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
    
    // MARK: - Setup
    
    private func setup() {
        self.backgroundColor = .white
        
        setupView()
        setupConstraints()
        setupCollectionView()
    }
    
    private func setupView() {
        self.addSubview(placesSegmentedControl)
        self.addSubview(tagsCollectionView)
    }
    
    private func setupConstraints() {
        setupPlacesSegmentedControlConstraints()
        setupTagsCollectionViewConstraints()
    }
    
    private func setupCollectionView() {
        tagsCollectionView.register(PlaceTagCollectionViewCell.self, forCellWithReuseIdentifier: PlaceTagCollectionViewCell.cellName)
        tagsCollectionView.delegate = self
        tagsCollectionView.dataSource = self
        tagsCollectionView.isScrollEnabled = true
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
    
    private func setupTagsCollectionViewConstraints() {
        tagsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tagsCollectionView.topAnchor.constraint(equalTo: placesSegmentedControl.bottomAnchor, constant: 10),
            tagsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            tagsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            tagsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - Extensions

extension FindPlacesMenuView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewData.count
    }
}

extension FindPlacesMenuView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceTagCollectionViewCell.cellName, for: indexPath) as! PlaceTagCollectionViewCell
        cell.configure(title: collectionViewData[indexPath.row], cornerRadius: .light)
        return cell
    }
}
