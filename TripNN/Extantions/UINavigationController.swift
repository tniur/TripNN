//
//  UINavigationController.swift
//  TripNN
//
//  Created by Pavel on 22.02.2024.
//

import UIKit

extension UINavigationController {
    func setupNavigationControllerStyles(title: String, navigationItem: UINavigationItem, navigationController: UINavigationController?) {
        
        navigationItem.backButtonTitle = ""
        navigationItem.title = title
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = .tripnnDark
        
        navigationController?.navigationBar.standardAppearance = UINavigationBarAppearance().tripNNScreenTitleAppearance()
        
    }
}
