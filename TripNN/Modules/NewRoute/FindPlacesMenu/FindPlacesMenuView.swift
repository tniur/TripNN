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
    
    private let pricesCollectionViewItems = [
        TagsCollectionViewItemModel(title: "₽"),
        TagsCollectionViewItemModel(title: "₽₽"),
        TagsCollectionViewItemModel(title: "₽₽₽"),
        TagsCollectionViewItemModel(title: "₽₽₽₽")
    ]
    
    private let ratingCollectionViewItems = [
        TagsCollectionViewItemModel(title: "от 3"),
        TagsCollectionViewItemModel(title: "от 3,5"),
        TagsCollectionViewItemModel(title: "от 4"),
        TagsCollectionViewItemModel(title: "от 4,5")
    ]
    
    private let distanceCollectionViewItems = [
        TagsCollectionViewItemModel(title: "до 1 км"),
        TagsCollectionViewItemModel(title: "до 2 км"),
        TagsCollectionViewItemModel(title: "до 5 км"),
        TagsCollectionViewItemModel(title: "до 10 км")
    ]
    
    private let categoryCollectionViewItems = [
        TagsCollectionViewItemModel(title: "Кафе"),
        TagsCollectionViewItemModel(title: "Рестораны"),
        TagsCollectionViewItemModel(title: "Бары"),
        TagsCollectionViewItemModel(title: "Кофейни"),
        TagsCollectionViewItemModel(title: "Столовые"),
        TagsCollectionViewItemModel(title: "Быстрое питание"),
        TagsCollectionViewItemModel(title: "Суши-бары"),
        TagsCollectionViewItemModel(title: "Пиццерии"),
        TagsCollectionViewItemModel(title: "Кафе-кондитерские"),
        TagsCollectionViewItemModel(title: "Рюмочные"),
        TagsCollectionViewItemModel(title: "Кондитерские изделия"),
        TagsCollectionViewItemModel(title: "Пекарни"),
    ]
    
    private lazy var collectionViewSections = [
        TagsCollectionViewSectionModel(type: .prices, title: String(localized: TagsCollectionViewSectionType.prices.rawValue), items: pricesCollectionViewItems),
        TagsCollectionViewSectionModel(type: .rating, title: String(localized: TagsCollectionViewSectionType.rating.rawValue), items: ratingCollectionViewItems),
        TagsCollectionViewSectionModel(type: .distance, title: String(localized: TagsCollectionViewSectionType.distance.rawValue), items: distanceCollectionViewItems),
        TagsCollectionViewSectionModel(type: .category, title: String(localized: TagsCollectionViewSectionType.category.rawValue), items: categoryCollectionViewItems)
    ]
    
    // MARK: - View
    
    private lazy var placesSegmentedControl = SegmentedControl(items: segmentedControlItems)
    
    // MARK: - CollectionView Settings
    
    private lazy var tagsCollectionView =  UICollectionView(frame: .zero, collectionViewLayout: collectionViewLeftLayout)
    
    private lazy var collectionViewLeftLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, env in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(56))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.contentInsets = .init(top: 12, leading: 0, bottom: 0, trailing: 0)
            group.interItemSpacing = .fixed(12)
            
            let section = NSCollectionLayoutSection(group: group)
            
            let header = self.createSectionHeader()
            section.boundarySupplementaryItems = [header]
            
            return section
        }
        return layout
    }()
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize,
                                                                              elementKind: UICollectionView.elementKindSectionHeader,
                                                                              alignment: .top)
        return layoutSectionHeader
    }
    
    private lazy var collectionViewDataSource: UICollectionViewDiffableDataSource<TagsCollectionViewSectionModel, TagsCollectionViewItemModel> = {
        let dataSource = UICollectionViewDiffableDataSource<TagsCollectionViewSectionModel, TagsCollectionViewItemModel>(collectionView: tagsCollectionView, cellProvider: { (collectionView, indexPath, tag) -> UICollectionViewCell? in
            switch self.collectionViewSections[indexPath.section].type {
            case .rating, .distance:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceTagCollectionViewCell.reuseId, for: indexPath) as? PlaceTagCollectionViewCell
                cell?.configure(title: tag.title, cornerRadius: .strong)
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceTagCollectionViewCell.reuseId, for: indexPath) as? PlaceTagCollectionViewCell
                cell?.configure(title: tag.title, cornerRadius: .light)
                return cell
            }
        })
        
        dataSource.supplementaryViewProvider = {
            tagsCollectionView, kind, indexPath in
            guard let sectionHeader = tagsCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TagCollectionSectionHeader.reuseId, for: indexPath) as? TagCollectionSectionHeader else { return nil }
            
            guard let currentCell = dataSource.itemIdentifier(for: indexPath) else { return nil }
            guard let section = dataSource.snapshot().sectionIdentifier(containingItem: currentCell) else { return nil }
            if section.title.isEmpty { return nil }
            
            sectionHeader.configure(text: section.title)
            return sectionHeader
        }
        
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
        self.addSubview(tagsCollectionView)
        self.addSubview(placesSegmentedControl)
    }
    
    private func setupConstraints() {
        setupPlacesSegmentedControlConstraints()
        setupTagsCollectionViewConstraints()
    }
    
    private func setupCollectionView() {
        tagsCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        tagsCollectionView.allowsMultipleSelection = true
        tagsCollectionView.showsVerticalScrollIndicator = false
        
        tagsCollectionView.delegate = self
        
        tagsCollectionView.register(PlaceTagCollectionViewCell.self, forCellWithReuseIdentifier: PlaceTagCollectionViewCell.reuseId)
        tagsCollectionView.register(TagCollectionSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TagCollectionSectionHeader.reuseId)
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
            tagsCollectionView.topAnchor.constraint(equalTo: placesSegmentedControl.bottomAnchor, constant: -10),
            tagsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            tagsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            tagsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - Extension UICollectionView

extension FindPlacesMenuView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = collectionViewDataSource.sectionIdentifier(for: indexPath.section) else { return }
        
        if (section.type == .rating || section.type == .distance) {
            let cells = getCellsInSection(collectionView, indexPath.section)
            cells.forEach{$0.setUnSelectCellStyle()}
            collectionView.deselectItem(at: indexPath, animated: false)
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as! PlaceTagCollectionViewCell
        cell.setSelectCellStyle()
        
        // guard var currentCell = collectionViewDataSource.itemIdentifier(for: indexPath) else { return }
        // print(currentCell.title)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PlaceTagCollectionViewCell
        cell.setUnSelectCellStyle()
    }
    
    private func getCellsInSection(_ collectionView: UICollectionView, _ section: Int) -> [PlaceTagCollectionViewCell] {
        var cellsInSection = [PlaceTagCollectionViewCell]()
        
        let numberOfItemsInSection = collectionView.numberOfItems(inSection: section)
        
        for itemIndex in 0..<numberOfItemsInSection {
            let indexPath = IndexPath(item: itemIndex, section: section)
            if let cell = collectionView.cellForItem(at: indexPath) {
                cellsInSection.append(cell as! PlaceTagCollectionViewCell)
            }
        }
        
        return cellsInSection
    }
}
