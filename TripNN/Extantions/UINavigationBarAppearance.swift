//
//  UINavigationBarAppearance.swift
//  TripNN
//
//  Created by Pavel on 22.02.2024.
//

import UIKit

extension UINavigationBarAppearance {
    func tripNNAppearance() -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .tripnnWhite
        appearance.backgroundEffect = nil
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        if let titleFont = UIFont(name: "Montserrat-SemiBold", size: 16) {
            appearance.titleTextAttributes = [NSAttributedString.Key.font: titleFont, NSAttributedString.Key.foregroundColor: UIColor.tripnnDark]
        }
        if let largeTitleFont = UIFont(name: "Montserrat-SemiBold", size: 30) {
            appearance.largeTitleTextAttributes = [NSAttributedString.Key.font: largeTitleFont, NSAttributedString.Key.foregroundColor: UIColor.tripnnDark]
        }
        return appearance
    }
}
