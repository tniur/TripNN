//
//  ThemeSettingsSectionViewController.swift
//  TripNN
//
//  Created by Pavel on 02.03.2024.
//

import UIKit

final class ThemeSettingsSectionViewController: UIViewController {
    
    weak var settingViewController: SettingsScreenViewController?
    
    // MARK: - View
    
    weak var themeSettingsSectionView: ThemeSettingsSectionView? {
        return self.view as? ThemeSettingsSectionView
    }
    
    // MARK: - Init
    
    init(settingViewController: SettingsScreenViewController) {
        self.settingViewController = settingViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func loadView() {
        self.view = ThemeSettingsSectionView(frame: UIScreen.main.bounds)
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupActions()
    }
    
    private func setupActions() {
        themeSettingsSectionView?.onDismissAction = { [weak self] in self?.closeBottomSheetViewController() }
    }
    
    // MARK: - Actions
    
    @objc private func closeBottomSheetViewController() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
