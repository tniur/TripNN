//
//  UINavigationController.swift
//  TripNN
//
//  Created by Pavel on 22.02.2024.
//

import UIKit

extension UINavigationController {
    func setupNavigationControllerStyles(title: String, navigationItem: UINavigationItem, navigationController: UINavigationController?) {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .tripnnDark
        navigationItem.backButtonTitle = ""
        navigationItem.title = title
        if #available(iOS 15, *) {
            navigationController?.navigationBar.standardAppearance = UINavigationBarAppearance().tripNNAppearance()
        } else {
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Montserrat-SemiBold", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.tripnnDark]
        }
    }
}
