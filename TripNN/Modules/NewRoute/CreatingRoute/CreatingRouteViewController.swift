//
//  CreatingRouteViewController.swift
//  TripNN
//
//  Created by Pavel on 19.02.2024.
//

import UIKit

final class CreatingRouteViewController: UIViewController {
    
    // MARK: - View
    
    weak var newRouteSettingsView: CreatingRouteView? {
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
    
    // MARK: - Setup
    
    private func setup() {
        setupNavigationController()
        setupActions()
    }
    
    private func setupActions() {
        
    }
    
    private func setupNavigationController() {
        navigationController?.setupNavigationControllerStyles(title: String(localized: "build_new_route"), navigationItem: navigationItem, navigationController: navigationController)
    }

}
