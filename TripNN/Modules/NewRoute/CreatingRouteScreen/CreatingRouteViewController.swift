//
//  CreatingRouteViewController.swift
//  TripNN
//
//  Created by Pavel on 19.02.2024.
//

import UIKit

final class CreatingRouteViewController: UIViewController {
    
    // MARK: - View
    
    weak var creatingRouteView: CreatingRouteView? {
        return self.view as? CreatingRouteView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func loadView() {
        self.view = CreatingRouteView(frame: UIScreen.main.bounds)
    }
    
    // MARK: - Action
    
    private func openFindPlaceMenuAction() {
        let rootController = FindPlacesMenuViewController()
        let navigationController = UINavigationController(rootViewController: rootController)
        
        let bottomSheet = navigationController
        if let sheet = bottomSheet.sheetPresentationController {
             sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        present(bottomSheet, animated: true)
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupNavigationController()
        setupActions()
        setupActions()
    }
    
    private func setupActions() {
        creatingRouteView?.onOpenFindPlaceMenuAction = { [weak self] in self?.openFindPlaceMenuAction() }
    }
    
    private func setupNavigationController() {
        navigationController?.setupNavigationControllerStyles(title: String(localized: "build_new_route"), navigationItem: navigationItem, navigationController: navigationController)
    }
}
