//
//  ItemCardModel.swift
//  TripNN
//
//  Created by Pavel on 17.02.2024.
//

import UIKit

enum ItemCardTypes {
    case route
    case place
}

struct ItemCardModel {
    let image: UIImage
    let type: ItemCardTypes
    let title: String
    let costInfo: String
}
