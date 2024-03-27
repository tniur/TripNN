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
    case prices = "prices"
    case distance = "distance"
    case last = " "
}

struct TagsCollectionViewSectionModel: Hashable {
    let type: TagsCollectionViewSectionType
    let title: String
    let items: [TagsCollectionViewItemModel]
}
