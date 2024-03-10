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
        settingsScreenView?.onThemeSectionAction = { [weak self] in self?.openThemeSettingSection() }
        settingsScreenView?.onLanguageSectionAction = { [weak self] in self?.openLanguageSettingSection() }
    }
    
    private func setupNavigationController() {
        navigationController?.setupNavigationControllerStyles(title: "Настройки", navigationItem: navigationItem, navigationController: navigationController)
    }
    
    // MARK: - Actions
    
    @objc private func openThemeSettingSection() {
        let bottomSheet = ThemeSettingsSectionViewController()
        if let sheet = bottomSheet.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.preferredCornerRadius = 20
        }
        present(bottomSheet, animated: true)
    }
    
    @objc private func openLanguageSettingSection() {
        if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsUrl)
        }
    }
}
