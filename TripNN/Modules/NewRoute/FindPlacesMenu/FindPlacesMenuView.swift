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
    
    private let categoryCollectionViewItems = [TagsCollectionViewItemModel(title: "Кафе"), TagsCollectionViewItemModel(title: "Рестораны"), TagsCollectionViewItemModel(title: "Бары"), TagsCollectionViewItemModel(title: "Пиццерии"), TagsCollectionViewItemModel(title: "Быстрое питание"), TagsCollectionViewItemModel(title: "Кофейни"), TagsCollectionViewItemModel(title: "Столовые"), TagsCollectionViewItemModel(title: "Суши-бары"), TagsCollectionViewItemModel(title: "Рюмочные"), TagsCollectionViewItemModel(title: "Кондитерские изделия"), TagsCollectionViewItemModel(title: "Кондитерские")]
    
    private let ratingCollectionViewItems = [TagsCollectionViewItemModel(title: "Низкий"), TagsCollectionViewItemModel(title: "Средний"), TagsCollectionViewItemModel(title: "Высокий")]
    
    private lazy var collectionViewSections = [TagsCollectionViewSectionModel(type: .category, title: String(localized: TagsCollectionViewSectionType.category.rawValue), items: categoryCollectionViewItems),
                                               TagsCollectionViewSectionModel(type: .rating, title: String(localized: TagsCollectionViewSectionType.rating.rawValue), items: ratingCollectionViewItems)]
    
    // MARK: - View
    
    private lazy var placesSegmentedControl = SegmentedControl(items: segmentedControlItems)
    
    // MARK: - CollectionView Settings
    
    private lazy var tagsCollectionView =  UICollectionView(frame: .zero, collectionViewLayout: collectionViewLeftLayout)
    
    private let collectionViewLeftLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, env in
            let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(56))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.contentInsets = .init(top: 12, leading: 0, bottom: 0, trailing: 0)
            group.interItemSpacing = .fixed(12)
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
        return layout
    }()
    
    private lazy var collectionViewDataSource: UICollectionViewDiffableDataSource<TagsCollectionViewSectionModel, TagsCollectionViewItemModel> = {
        let dataSource = UICollectionViewDiffableDataSource<TagsCollectionViewSectionModel, TagsCollectionViewItemModel>(collectionView: tagsCollectionView, cellProvider: { (collectionView, indexPath, tag) -> UICollectionViewCell? in
            switch self.collectionViewSections[indexPath.section].type {
            case .category:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceTagCollectionViewCell.reuseId, for: indexPath) as? PlaceTagCollectionViewCell
                cell?.configure(title: tag.title, cornerRadius: .light)
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceTagCollectionViewCell.reuseId, for: indexPath) as? PlaceTagCollectionViewCell
                cell?.configure(title: tag.title, cornerRadius: .strong)
                return cell
            }
        })
        return dataSource
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
        self.backgroundColor = .white
        
        setupView()
        setupConstraints()
        
        setupCollectionView()
        setupCollectionData()
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
        tagsCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tagsCollectionView.register(PlaceTagCollectionViewCell.self, forCellWithReuseIdentifier: PlaceTagCollectionViewCell.reuseId)
    }
    
    private func setupCollectionData() {
        var snapshot = NSDiffableDataSourceSnapshot<TagsCollectionViewSectionModel, TagsCollectionViewItemModel>()
        snapshot.appendSections(collectionViewSections)
        
        for section in collectionViewSections {
            snapshot.appendItems(section.items, toSection: section)
        }
        
        collectionViewDataSource.apply(snapshot)
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
