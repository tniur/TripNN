//
//  PlaceFiltersMenuView.swift
//  TripNN
//
//  Created by Pavel on 11.03.2024.
//

import UIKit

final class PlaceFiltersMenuView: UIView {
    
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
        TagsCollectionViewSectionModel(type: .category, title: String(localized: TagsCollectionViewSectionType.category.rawValue), items: foodCategoryCollectionViewItems),
        TagsCollectionViewSectionModel(type: .last, title: String(localized: TagsCollectionViewSectionType.last.rawValue), items: lastCollectionViewItems)
    ]
    
    private lazy var leisureCollectionViewSections = [
        TagsCollectionViewSectionModel(type: .rating, title: String(localized: TagsCollectionViewSectionType.rating.rawValue), items: ratingCollectionViewItems),
        TagsCollectionViewSectionModel(type: .distance, title: String(localized: TagsCollectionViewSectionType.distance.rawValue), items: distanceCollectionViewItems),
        TagsCollectionViewSectionModel(type: .category, title: String(localized: TagsCollectionViewSectionType.category.rawValue), items: leisureCategoryCollectionViewItems),
        TagsCollectionViewSectionModel(type: .last, title: String(localized: TagsCollectionViewSectionType.last.rawValue), items: lastCollectionViewItems)
    ]
    
    private lazy var cultureCollectionViewSections = [
        TagsCollectionViewSectionModel(type: .rating, title: String(localized: TagsCollectionViewSectionType.rating.rawValue), items: ratingCollectionViewItems),
        TagsCollectionViewSectionModel(type: .distance, title: String(localized: TagsCollectionViewSectionType.distance.rawValue), items: distanceCollectionViewItems),
        TagsCollectionViewSectionModel(type: .category, title: String(localized: TagsCollectionViewSectionType.category.rawValue), items: cultureCategoryCollectionViewItems),
        TagsCollectionViewSectionModel(type: .last, title: String(localized: TagsCollectionViewSectionType.last.rawValue), items: lastCollectionViewItems)
    ]
    
    private lazy var catalogTypeSegmentedControl: SegmentedControl = {
        let segmentControl = SegmentedControl(items: getSegmentControlItems())
        
        segmentControl.addTarget(self, action: #selector(catalogTypeChanged), for: .valueChanged)
        
        return segmentControl
    }()
    
    private var foodFiltersData = FiltersDataModel()
    private var cultureFiltersData = FiltersDataModel()
    private var leisureFiltersData = FiltersDataModel()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    private let showResultButton = BigButton(withTitle: String(localized: "show_results"))
        
    // MARK: - Data
    
    private let lastCollectionViewItems: [TagsCollectionViewItemModel] = [TagsCollectionViewItemModel(title: "last", id: 0)]
    
    private let pricesCollectionViewItems = [
        TagsCollectionViewItemModel(title: "₽", id: 0),
        TagsCollectionViewItemModel(title: "₽₽", id: 1),
        TagsCollectionViewItemModel(title: "₽₽₽", id: 2),
        TagsCollectionViewItemModel(title: "₽₽₽₽", id: 3)
    ]
    
    private let ratingCollectionViewItems = [
        TagsCollectionViewItemModel(title: "от 3 ★", id: 0),
        TagsCollectionViewItemModel(title: "от 3,5 ★", id: 1),
        TagsCollectionViewItemModel(title: "от 4 ★", id: 2),
        TagsCollectionViewItemModel(title: "от 4,5 ★", id: 3)
    ]
    
    private let distanceCollectionViewItems = [
        TagsCollectionViewItemModel(title: "до 1 км", id: 0),
        TagsCollectionViewItemModel(title: "до 2 км", id: 1),
        TagsCollectionViewItemModel(title: "до 5 км", id: 2),
        TagsCollectionViewItemModel(title: "до 10 км", id: 3)
    ]
    
    private let foodCategoryCollectionViewItems = [
        TagsCollectionViewItemModel(title: "Кафе", id: 161),
        TagsCollectionViewItemModel(title: "Рестораны", id: 164),
        TagsCollectionViewItemModel(title: "Бары", id: 159),
        TagsCollectionViewItemModel(title: "Кофейни", id: 162),
        TagsCollectionViewItemModel(title: "Столовые", id: 166),
        TagsCollectionViewItemModel(title: "Быстрое питание", id: 165),
        TagsCollectionViewItemModel(title: "Суши-бары", id: 15791),
        TagsCollectionViewItemModel(title: "Пиццерии", id: 51459),
        TagsCollectionViewItemModel(title: "Кафе-кондитерские", id: 112658),
        TagsCollectionViewItemModel(title: "Рюмочные", id: 52248),
        TagsCollectionViewItemModel(title: "Кондитерские изделия", id: 363),
        TagsCollectionViewItemModel(title: "Пекарни", id: 111594),
    ]
    
    private let cultureCategoryCollectionViewItems = [
        TagsCollectionViewItemModel(title: "Музеи", id: 193),
        TagsCollectionViewItemModel(title: "Парки культуры и отдыха", id: 168),
        TagsCollectionViewItemModel(title: "Дома / дворцы культуры", id: 13787),
        TagsCollectionViewItemModel(title: "Интересные здания", id: 112670),
        TagsCollectionViewItemModel(title: "Природные достопримечательности", id: 112668),
        TagsCollectionViewItemModel(title: "Фонтаны", id: 112720)
    ]
    
    private let leisureCategoryCollectionViewItems = [
        TagsCollectionViewItemModel(title: "Кинотеатры", id: 192),
        TagsCollectionViewItemModel(title: "Боулинг", id: 170),
        TagsCollectionViewItemModel(title: "Ночные клубы", id: 173),
        TagsCollectionViewItemModel(title: "Бильярдные залы", id: 169),
        TagsCollectionViewItemModel(title: "Караоке-залы", id: 21387),
        TagsCollectionViewItemModel(title: "Стрелковые клубы", id: 6505),
        TagsCollectionViewItemModel(title: "Гольф-клубы", id: 6505),
        TagsCollectionViewItemModel(title: "Картинг", id: 51008),
        TagsCollectionViewItemModel(title: "Цирк", id: 685),
        TagsCollectionViewItemModel(title: "Уличные катки", id: 112872),
        TagsCollectionViewItemModel(title: "Бары", id: 159),
        TagsCollectionViewItemModel(title: "Зоопарк", id: 167),
        TagsCollectionViewItemModel(title: "Дельфинарий", id: 9508),
        TagsCollectionViewItemModel(title: "Антикафе", id: 72370),
        TagsCollectionViewItemModel(title: "Научно-развлекательные центры", id: 110345),
        TagsCollectionViewItemModel(title: "Аквапарки / Водные аттракционы", id: 537),
        TagsCollectionViewItemModel(title: "Батутные центры", id: 110427),
        TagsCollectionViewItemModel(title: "Аттракционы", id: 110358),
        TagsCollectionViewItemModel(title: "Ледовые дворцы / Катки", id: 11974),
        TagsCollectionViewItemModel(title: "Смотровые площадки", id: 111526),
        TagsCollectionViewItemModel(title: "Пляжи / Зоны пляжного отдыха", id: 24353),
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
        setupActions()
        
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
        self.addSubview(showResultButton)
        self.addSubview(catalogTypeSegmentedControl)
    }
    
    private func setupConstraints() {
        setupPlacesSegmentedControlConstraints()
        setupTagsCollectionViewConstraints(collectionView: leisureTagsCollectionView)
        setupTagsCollectionViewConstraints(collectionView: foodTagsCollectionView)
        setupTagsCollectionViewConstraints(collectionView: cultureTagsCollectionView)
        setupFilterButtonConstraints()
    }
    
    private func setupCollectionView(collectionView: UICollectionView) {
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionView.allowsMultipleSelection = true
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.delegate = self
        
        collectionView.register(PlaceTagCollectionViewCell.self, forCellWithReuseIdentifier: PlaceTagCollectionViewCell.reuseId)
        collectionView.register(TagCollectionSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TagCollectionSectionHeader.reuseId)
    }
    
    //MARK: - Actions
    
    private func setupActions() {
        showResultButton.addTarget(self, action: #selector(showResultButtonAction), for: .touchUpInside)
    }
    
    @objc private func showResultButtonAction() {
        let catalogIndex = catalogTypeSegmentedControl.selectedSegmentIndex
        if catalogIndex == 0 {
            print(cultureFiltersData)
        } else if catalogIndex == 1 {
            print(leisureFiltersData)
        } else if catalogIndex == 2 {
            print(foodFiltersData)
        }
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
    
    private func setupFilterButtonConstraints() {
        showResultButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            showResultButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            showResultButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

// MARK: - SegmentControl Configure

private extension PlaceFiltersMenuView {
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

private extension PlaceFiltersMenuView {
    
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
            case .last:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceTagCollectionViewCell.reuseId, for: indexPath) as? PlaceTagCollectionViewCell
                cell?.configure(title: tag.title, cornerRadius: .strong)
                cell?.hideCell()
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

extension PlaceFiltersMenuView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sectionDataSource = getCollectionDataSource(collectionView: collectionView)
        guard let section = sectionDataSource?.sectionIdentifier(for: indexPath.section) else { return }
        
        insertTagIdToData(collectionView: collectionView, dataSource: sectionDataSource, section: section, indexPath: indexPath)
        
        if (section.type == .rating || section.type == .distance) {
            deselectCellsInSection(collectionView: collectionView, indexPath: indexPath)
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as! PlaceTagCollectionViewCell
        cell.setSelectCellStyle()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let sectionDataSource = getCollectionDataSource(collectionView: collectionView)
        guard let section = sectionDataSource?.sectionIdentifier(for: indexPath.section) else { return }
        
        removeTagIdToData(collectionView: collectionView, dataSource: sectionDataSource, section: section, indexPath: indexPath)
        
        let cell = collectionView.cellForItem(at: indexPath) as! PlaceTagCollectionViewCell
        cell.setUnSelectCellStyle()
    }
    
    private func insertTagIdToData(collectionView: UICollectionView, dataSource: UICollectionViewDiffableDataSource<TagsCollectionViewSectionModel, TagsCollectionViewItemModel>?, section: TagsCollectionViewSectionModel, indexPath: IndexPath) {
        guard let currentCell = dataSource?.itemIdentifier(for: indexPath) else { return }
        if collectionView == foodTagsCollectionView {
            insertTagToDataSection(id: currentCell.id, sectionType: section.type, filterData: &foodFiltersData)
        } else if collectionView == leisureTagsCollectionView {
            insertTagToDataSection(id: currentCell.id, sectionType: section.type, filterData: &leisureFiltersData)
        } else if collectionView == cultureTagsCollectionView {
            insertTagToDataSection(id: currentCell.id, sectionType: section.type, filterData: &cultureFiltersData)
        }
    }
    
    private func removeTagIdToData(collectionView: UICollectionView, dataSource: UICollectionViewDiffableDataSource<TagsCollectionViewSectionModel, TagsCollectionViewItemModel>?, section: TagsCollectionViewSectionModel, indexPath: IndexPath) {
        guard let currentCell = dataSource?.itemIdentifier(for: indexPath) else { return }
        if collectionView == foodTagsCollectionView {
            removeTagFromDataSection(id: currentCell.id, sectionType: section.type, filterData: &foodFiltersData)
        } else if collectionView == leisureTagsCollectionView {
            removeTagFromDataSection(id: currentCell.id, sectionType: section.type, filterData: &leisureFiltersData)
        } else if collectionView == cultureTagsCollectionView {
            removeTagFromDataSection(id: currentCell.id, sectionType: section.type, filterData: &cultureFiltersData)
        }
    }
    
    private func insertTagToDataSection(id: Int, sectionType: TagsCollectionViewSectionType, filterData: inout FiltersDataModel) {
        switch sectionType {
        case .category:
            if (filterData.category == nil) {
                filterData.category = Set<Int>()
            }
            filterData.category?.insert(id)
        case .rating:
            filterData.rating = id
        case .prices:
            filterData.prices = id
        case .distance:
            filterData.distance = id
        case .last:
            break
        }
    }
    
    private func removeTagFromDataSection(id: Int, sectionType: TagsCollectionViewSectionType, filterData: inout FiltersDataModel) {
        switch sectionType {
        case .category:
            filterData.category?.remove(id)
            if let filterDataCategory = filterData.category {
                if (filterDataCategory.isEmpty) {
                    filterData.category = nil
                }
            }
        case .rating:
            filterData.rating = nil
        case .prices:
            filterData.prices = nil
        case .distance:
            filterData.distance = nil
        case .last:
            break
        }
    }
    
    private func getCollectionDataSource(collectionView: UICollectionView) -> UICollectionViewDiffableDataSource<TagsCollectionViewSectionModel, TagsCollectionViewItemModel>? {
        
        if collectionView == foodTagsCollectionView {
            return foodCollectionViewDataSource
        } else if collectionView == leisureTagsCollectionView {
            return leisureCollectionViewDataSource
        } else if collectionView == cultureTagsCollectionView {
            return cultureCollectionViewDataSource
        } else {
            return nil
        }
    }
    
    private func deselectCellsInSection(collectionView: UICollectionView, indexPath: IndexPath) {
        let numberOfItemsInSection = collectionView.numberOfItems(inSection: indexPath.section)
        
        for itemIndex in 0..<numberOfItemsInSection {
            let itemIndexPath = IndexPath(item: itemIndex, section: indexPath.section)
            
            if itemIndexPath != indexPath {
                collectionView.deselectItem(at: itemIndexPath, animated: false)
                let cell = collectionView.cellForItem(at: itemIndexPath) as! PlaceTagCollectionViewCell
                cell.setUnSelectCellStyle()
            }
        }
    }
}
