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
    
    private var foodCollectionViewDataSource: UICollectionViewDiffableDataSource<TagsCollectionViewSectionModel, TagsCollectionViewItemModel>?
    
    private var leisureCollectionViewDataSource: UICollectionViewDiffableDataSource<TagsCollectionViewSectionModel, TagsCollectionViewItemModel>?
    
    private var cultureCollectionViewDataSource: UICollectionViewDiffableDataSource<TagsCollectionViewSectionModel, TagsCollectionViewItemModel>?
    
    private lazy var foodTagsCollectionView =  UICollectionView(frame: .zero, collectionViewLayout: getCollectionViewLeftLayout())
    
    private lazy var leisureTagsCollectionView =  UICollectionView(frame: .zero, collectionViewLayout: getCollectionViewLeftLayout())
    
    private lazy var cultureTagsCollectionView =  UICollectionView(frame: .zero, collectionViewLayout: getCollectionViewLeftLayout())
    
    private lazy var foodCollectionViewSections = [
        TagsCollectionViewSectionModel(type: .prices, title: String(localized: TagsCollectionViewSectionType.prices.rawValue), items: pricesCollectionViewItems),
        TagsCollectionViewSectionModel(type: .rating, title: String(localized: TagsCollectionViewSectionType.rating.rawValue), items: ratingCollectionViewItems),
        TagsCollectionViewSectionModel(type: .distance, title: String(localized: TagsCollectionViewSectionType.distance.rawValue), items: distanceCollectionViewItems),
        TagsCollectionViewSectionModel(type: .category, title: String(localized: TagsCollectionViewSectionType.category.rawValue), items: foodCategoryCollectionViewItems)
    ]
    
    private lazy var leisureCollectionViewSections = [
        TagsCollectionViewSectionModel(type: .rating, title: String(localized: TagsCollectionViewSectionType.rating.rawValue), items: ratingCollectionViewItems),
        TagsCollectionViewSectionModel(type: .distance, title: String(localized: TagsCollectionViewSectionType.distance.rawValue), items: distanceCollectionViewItems),
        TagsCollectionViewSectionModel(type: .category, title: String(localized: TagsCollectionViewSectionType.category.rawValue), items: leisureCategoryCollectionViewItems)
    ]
    
    private lazy var cultureCollectionViewSections = [
        TagsCollectionViewSectionModel(type: .rating, title: String(localized: TagsCollectionViewSectionType.rating.rawValue), items: ratingCollectionViewItems),
        TagsCollectionViewSectionModel(type: .distance, title: String(localized: TagsCollectionViewSectionType.distance.rawValue), items: distanceCollectionViewItems),
        TagsCollectionViewSectionModel(type: .category, title: String(localized: TagsCollectionViewSectionType.category.rawValue), items: cultureCategoryCollectionViewItems)
    ]
    
    private lazy var catalogTypeSegmentedControl: SegmentedControl = {
        let segmentControl = SegmentedControl(items: getSegmentControlItems())
        
        segmentControl.addTarget(self, action: #selector(catalogTypeChanged), for: .valueChanged)
        
        return segmentControl
    }()
    
    // MARK: - Data
    
    private let pricesCollectionViewItems = [
        TagsCollectionViewItemModel(title: "₽"),
        TagsCollectionViewItemModel(title: "₽₽"),
        TagsCollectionViewItemModel(title: "₽₽₽"),
        TagsCollectionViewItemModel(title: "₽₽₽₽")
    ]
    
    private let ratingCollectionViewItems = [
        TagsCollectionViewItemModel(title: "от 3 ★"),
        TagsCollectionViewItemModel(title: "от 3,5 ★"),
        TagsCollectionViewItemModel(title: "от 4 ★"),
        TagsCollectionViewItemModel(title: "от 4,5 ★")
    ]
    
    private let distanceCollectionViewItems = [
        TagsCollectionViewItemModel(title: "до 1 км"),
        TagsCollectionViewItemModel(title: "до 2 км"),
        TagsCollectionViewItemModel(title: "до 5 км"),
        TagsCollectionViewItemModel(title: "до 10 км")
    ]
    
    private let foodCategoryCollectionViewItems = [
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
    
    private let cultureCategoryCollectionViewItems = [
        TagsCollectionViewItemModel(title: "Музеи"),
        TagsCollectionViewItemModel(title: "Парки культуры и отдыха"),
        TagsCollectionViewItemModel(title: "Дома / дворцы культуры"),
        TagsCollectionViewItemModel(title: "Интересные здания"),
        TagsCollectionViewItemModel(title: "Природные достопримечательности"),
        TagsCollectionViewItemModel(title: "Фонтаны")
    ]
    
    private let leisureCategoryCollectionViewItems = [
        TagsCollectionViewItemModel(title: "Кинотеатры"),
        TagsCollectionViewItemModel(title: "Боулинг"),
        TagsCollectionViewItemModel(title: "Ночные клубы"),
        TagsCollectionViewItemModel(title: "Бильярдные залы"),
        TagsCollectionViewItemModel(title: "Караоке-залы"),
        TagsCollectionViewItemModel(title: "Стрелковые клубы"),
        TagsCollectionViewItemModel(title: "Гольф-клубы"),
        TagsCollectionViewItemModel(title: "Картинг"),
        TagsCollectionViewItemModel(title: "Цирк"),
        TagsCollectionViewItemModel(title: "Уличные катки"),
        TagsCollectionViewItemModel(title: "Бары"),
        TagsCollectionViewItemModel(title: "Зоопарк"),
        TagsCollectionViewItemModel(title: "Дельфинарий"),
        TagsCollectionViewItemModel(title: "Антикафе"),
        TagsCollectionViewItemModel(title: "Научно-развлекательные центры"),
        TagsCollectionViewItemModel(title: "Аквапарки / Водные аттракционы"),
        TagsCollectionViewItemModel(title: "Батутные центры"),
        TagsCollectionViewItemModel(title: "Аттракционы"),
        TagsCollectionViewItemModel(title: "Ледовые дворцы / Катки"),
        TagsCollectionViewItemModel(title: "Смотровые площадки"),
        TagsCollectionViewItemModel(title: "Пляжи / Зоны пляжного отдыха"),
    ]
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setup
    
    private func setup() {
        self.backgroundColor = .white
        
        setupView()
        setupConstraints()
        
        setupCollectionView(collectionView: foodTagsCollectionView)
        setupCollectionView(collectionView: leisureTagsCollectionView)
        setupCollectionView(collectionView: cultureTagsCollectionView)
        
        foodCollectionViewDataSource = setupCollectionViewDataSource(collection: foodTagsCollectionView, collectionSections: foodCollectionViewSections)
        leisureCollectionViewDataSource = setupCollectionViewDataSource(collection: leisureTagsCollectionView, collectionSections: leisureCollectionViewSections)
        cultureCollectionViewDataSource = setupCollectionViewDataSource(collection: cultureTagsCollectionView, collectionSections: cultureCollectionViewSections)
        
        setupCollectionViewCollectionData(dataSource: foodCollectionViewDataSource, collectionViewSections: foodCollectionViewSections)
        setupCollectionViewCollectionData(dataSource: leisureCollectionViewDataSource, collectionViewSections: leisureCollectionViewSections)
        setupCollectionViewCollectionData(dataSource: cultureCollectionViewDataSource, collectionViewSections: cultureCollectionViewSections)
        
        showCollectionView(withIndex: 0)
    }
    
    private func setupView() {
        self.addSubview(foodTagsCollectionView)
        self.addSubview(leisureTagsCollectionView)
        self.addSubview(cultureTagsCollectionView)
        self.addSubview(catalogTypeSegmentedControl)
    }
    
    private func setupConstraints() {
        setupPlacesSegmentedControlConstraints()
        setupTagsCollectionViewConstraints(collectionView: leisureTagsCollectionView)
        setupTagsCollectionViewConstraints(collectionView: foodTagsCollectionView)
        setupTagsCollectionViewConstraints(collectionView: cultureTagsCollectionView)
    }
    
    private func setupCollectionView(collectionView: UICollectionView) {
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionView.allowsMultipleSelection = true
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.delegate = self
        
        collectionView.register(PlaceTagCollectionViewCell.self, forCellWithReuseIdentifier: PlaceTagCollectionViewCell.reuseId)
        collectionView.register(TagCollectionSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TagCollectionSectionHeader.reuseId)
    }
    
    // MARK: - Constraints
    
    private func setupPlacesSegmentedControlConstraints() {
        catalogTypeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            catalogTypeSegmentedControl.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            catalogTypeSegmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            catalogTypeSegmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
    
    private func setupTagsCollectionViewConstraints(collectionView: UICollectionView) {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: catalogTypeSegmentedControl.bottomAnchor, constant: -10),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - SegmentControl Configure

private extension FindPlacesMenuView {
    func getSegmentControlItems() -> [String] {
        [String(localized: "culture"), String(localized: "leisure"), String(localized: "food")]
    }
    
    @objc func catalogTypeChanged() {
        let index = catalogTypeSegmentedControl.selectedSegmentIndex
        
        showCollectionView(withIndex: index)
    }
    
    func showCollectionView(withIndex segmentIndex: Int) {
        foodTagsCollectionView.isHidden = true
        leisureTagsCollectionView.isHidden = true
        cultureTagsCollectionView.isHidden = true
        
        switch segmentIndex {
            
        case 0:
            cultureTagsCollectionView.isHidden = false
        case 1:
            leisureTagsCollectionView.isHidden = false
        case 2:
            foodTagsCollectionView.isHidden = false
        default:
            foodTagsCollectionView.isHidden = true
            leisureTagsCollectionView.isHidden = true
            cultureTagsCollectionView.isHidden = true
        }
    }
}

// MARK: - CollectionView Configure

private extension FindPlacesMenuView {
    
    func getCollectionViewLeftLayout() -> UICollectionViewLayout {
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
    }
    
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize,
                                                                              elementKind: UICollectionView.elementKindSectionHeader,
                                                                              alignment: .top)
        return layoutSectionHeader
    }
    
    func setupCollectionViewDataSource(collection: UICollectionView, collectionSections: [TagsCollectionViewSectionModel]) -> UICollectionViewDiffableDataSource<TagsCollectionViewSectionModel, TagsCollectionViewItemModel> {
        let dataSource = UICollectionViewDiffableDataSource<TagsCollectionViewSectionModel, TagsCollectionViewItemModel>(collectionView: collection, cellProvider: { (collectionView, indexPath, tag) -> UICollectionViewCell? in
            switch collectionSections[indexPath.section].type {
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
    }
    
    func setupCollectionViewCollectionData(dataSource: UICollectionViewDiffableDataSource<TagsCollectionViewSectionModel, TagsCollectionViewItemModel>?, collectionViewSections: [TagsCollectionViewSectionModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<TagsCollectionViewSectionModel, TagsCollectionViewItemModel>()
        snapshot.appendSections(collectionViewSections)
        
        collectionViewSections.forEach{ snapshot.appendItems($0.items, toSection: $0) }
        
        dataSource?.apply(snapshot)
    }
}

// MARK: - CollectionView Delegate

extension FindPlacesMenuView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var sectionDataSource: UICollectionViewDiffableDataSource<TagsCollectionViewSectionModel, TagsCollectionViewItemModel>?
        
        if collectionView == foodTagsCollectionView {
            sectionDataSource = foodCollectionViewDataSource
        } else if collectionView == leisureTagsCollectionView {
            sectionDataSource = leisureCollectionViewDataSource
        } else if collectionView == cultureTagsCollectionView {
            sectionDataSource = cultureCollectionViewDataSource
        }
        
        guard let section = sectionDataSource?.sectionIdentifier(for: indexPath.section) else { return }
        
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
