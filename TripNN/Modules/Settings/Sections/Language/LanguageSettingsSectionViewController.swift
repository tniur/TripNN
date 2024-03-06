//
//  LanguageSettingsSectionViewController.swift
//  TripNN
//
//  Created by Pavel on 06.03.2024.
//

import UIKit

final class LanguageSettingsSectionViewController: UIViewController {
    
    // MARK: - View
    
    weak var languageSettingsSectionView: LanguageSettingsSectionView? {
        return self.view as? LanguageSettingsSectionView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func loadView() {
        self.view = LanguageSettingsSectionView(frame: UIScreen.main.bounds)
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupActions()
    }
    
    private func setupActions() {
        languageSettingsSectionView?.onDismissAction = { [weak self] in self?.closeBottomSheetViewController() }
    }
    
    // MARK: - Actions
    
    @objc private func closeBottomSheetViewController() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
