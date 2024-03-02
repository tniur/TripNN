//
//  SettingsSectionBottomSheetViewController.swift
//  TripNN
//
//  Created by Pavel on 02.03.2024.
//

import UIKit

final class SettingsSectionBottomSheetViewController: UIViewController {
    
    // MARK: - View
    
    weak var settingsSectionBottomSheetView: SettingsSectionBottomSheetView? {
        return self.view as? SettingsSectionBottomSheetView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func loadView() {
        self.view = SettingsSectionBottomSheetView(frame: UIScreen.main.bounds)
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupActions()
    }
    
    private func setupActions() {
        settingsSectionBottomSheetView?.onCloseButtonAction = { [weak self] in self?.closeBottomSheetViewController() }
    }
    
    // MARK: - Actions
    
    @objc private func closeBottomSheetViewController() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
