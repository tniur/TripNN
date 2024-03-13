//
//  ThemeUserDefaults.swift
//  TripNN
//
//  Created by Pavel on 11.03.2024.
//

import UIKit

enum Theme: Int {
    case light
    case dark
    case device
    
    func getUserInterfaceStyle() -> UIUserInterfaceStyle {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        case .device:
            return .unspecified
        }
    }
}

extension UserDefaults {
    
    var theme: Theme {
        get {
            Theme(rawValue: UserDefaults.standard.integer(forKey: "selectedTheme")) ?? .device
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "selectedTheme")
        }
    }
    
}
