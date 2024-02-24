//
//  UINavigationBarAppearance.swift
//  TripNN
//
//  Created by Pavel on 22.02.2024.
//

import UIKit

extension UINavigationBarAppearance {
    func tripNNScreenTitleAppearance() -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .tripnnWhite
        appearance.backgroundEffect = nil
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        if let titleFont = UIFont(name: SCREEN_TITLE_FONT, size: SCREEN_TITLE_SIZE) {
            appearance.titleTextAttributes = [NSAttributedString.Key.font: titleFont, NSAttributedString.Key.foregroundColor: UIColor.tripnnDark]
        }
        if let largeTitleFont = UIFont(name: SCREEN_TITLE_FONT, size: SCREEN_LARGE_TITLE_SIZE) {
            appearance.largeTitleTextAttributes = [NSAttributedString.Key.font: largeTitleFont, NSAttributedString.Key.foregroundColor: UIColor.tripnnDark]
        }
        return appearance
    }
}
