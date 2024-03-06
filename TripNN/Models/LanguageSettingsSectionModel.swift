//
//  ThemeSettingsSectionModel.swift
//  TripNN
//
//  Created by Pavel on 03.03.2024.
//



import UIKit

enum LanguageTypes {
    case rus
    case eng
}

struct LanguageSettingsSectionModel {
    let title: String
    let value: LanguageTypes
}
