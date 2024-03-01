//
//  SettingsViewController.swift
//  TripNN
//
//  Created by Pavel on 29.02.2024.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    // MARK: - View
    
    weak var settingsView: SettingsView? {
        return self.view as? SettingsView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func loadView() {
        self.view = SettingsView(frame: UIScreen.main.bounds)
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupNavigationController()
        setupActions()
    }
    
    private func setupActions() {
        
    }
    
    private func setupNavigationController() {
        navigationController?.setupNavigationControllerStyles(title: "Настройки", navigationItem: navigationItem, navigationController: navigationController)
    }
}
