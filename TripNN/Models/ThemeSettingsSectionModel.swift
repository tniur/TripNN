//
//  ThemeSettingsSectionModel.swift
//  TripNN
//
//  Created by Pavel on 03.03.2024.
//

import UIKit

enum ThemeTypes {
    case light
    case dark
    case system
}

struct ThemeSettingsSectionModel {
    let title: String
    let value: ThemeTypes
}
