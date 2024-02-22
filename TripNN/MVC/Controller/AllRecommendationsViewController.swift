//
//  AllRecommendationViewController.swift
//  TripNN
//
//  Created by Pavel on 20.02.2024.
//

import UIKit

class AllRecommendationsViewController: UIViewController {
    
    // MARK: - View
    
    weak var allRecommendationsView: AllRecommendationsView? {
        return self.view as? AllRecommendationsView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
    }
    
    override func loadView() {
        self.view = AllRecommendationsView(frame: UIScreen.main.bounds)
    }
}

extension AllRecommendationsViewController {
    private func setupNavigationController() {
        navigationItem.searchController = allRecommendationsView?.searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .tripnnDark
        navigationItem.backButtonTitle = ""
        navigationItem.title = "Готовые маршруты"
        if #available(iOS 15, *) {
            navigationController?.navigationBar.standardAppearance = UINavigationBarAppearance().tripNNAppearance()
        } else {
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Montserrat-SemiBold", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.tripnnDark]
        }
    }
}
