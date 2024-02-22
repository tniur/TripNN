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
        setup()
    }
    
    override func loadView() {
        self.view = AllRecommendationsView(frame: UIScreen.main.bounds)
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupNavigationController()
        setupActions()
    }
    
    private func setupActions() {
        allRecommendationsView?.onSelectTableCellAction = { [weak self] in self?.openItemCardBottomSheetAction() }
    }
    
    private func setupNavigationController() {
        navigationItem.searchController = allRecommendationsView?.searchController
        navigationController?.setupNavigationControllerStyles(title: "Готовые маршруты", navigationItem: navigationItem, navigationController: navigationController)
    }
    
    // MARK: Action
    
    private func openItemCardBottomSheetAction() {
        let bottomSheet = ItemCardBottomSheetViewController()
        if let sheet = bottomSheet.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        present(bottomSheet, animated: true)
    }
}
