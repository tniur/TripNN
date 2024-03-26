//
//  TagsCollectionViewSectionModel.swift
//  TripNN
//
//  Created by Pavel on 26.03.2024.
//

import Foundation

enum TagsCollectionViewSectionType: String.LocalizationValue {
    case category = "сategories"
    case rating = "rating"
}

struct TagsCollectionViewSectionModel: Hashable {
    let type: TagsCollectionViewSectionType
    let title: String
    let items: [TagsCollectionViewItemModel]
}
