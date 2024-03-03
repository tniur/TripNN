//
//  SettingsScreenViewController.swift
//  TripNN
//
//  Created by Pavel on 29.02.2024.
//

import UIKit

final class SettingsScreenViewController: UIViewController {
    
    // MARK: - View
    
    weak var settingsScreenView: SettingsScreenView? {
        return self.view as? SettingsScreenView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func loadView() {
        self.view = SettingsScreenView(frame: UIScreen.main.bounds)
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupNavigationController()
        setupActions()
    }
    
    private func setupActions() {
        settingsScreenView?.onSettingsSectionAction = { [weak self] in self?.openSettingSection() }
    }
    
    private func setupNavigationController() {
        navigationController?.setupNavigationControllerStyles(title: "Настройки", navigationItem: navigationItem, navigationController: navigationController)
    }
    
    // MARK: - Actions
    
    @objc private func openSettingSection() {
        let bottomSheet = ThemeSettingsSectionViewController()
        if let sheet = bottomSheet.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.preferredCornerRadius = 20
        }
        present(bottomSheet, animated: true)
    }
}
