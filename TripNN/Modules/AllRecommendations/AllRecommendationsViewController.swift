//
//  AllPreparedRoutesViewController.swift
//  TripNN
//
//  Created by Pavel on 20.02.2024.
//

import UIKit

class AllPreparedRoutesViewController: UIViewController {
    
    // MARK: - View
    
    weak var allPreparedRoutesView: AllPreparedRoutesView? {
        return self.view as? AllPreparedRoutesView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func loadView() {
        self.view = AllPreparedRoutesView(frame: UIScreen.main.bounds)
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupNavigationController()
        setupActions()
    }
    
    private func setupActions() {
        allPreparedRoutesView?.onSelectTableCellAction = { [weak self] in self?.openRouteDetailsBottomSheetAction() }
    }
    
    private func setupNavigationController() {
        navigationItem.searchController = allPreparedRoutesView?.searchController
        navigationController?.setupNavigationControllerStyles(title: "Готовые маршруты", navigationItem: navigationItem, navigationController: navigationController)
    }
     
    // MARK: Action
    
    private func openRouteDetailsBottomSheetAction() {
        let bottomSheet = RouteDetailsBottomSheetViewController()
        if let sheet = bottomSheet.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        present(bottomSheet, animated: true)
    }
}
