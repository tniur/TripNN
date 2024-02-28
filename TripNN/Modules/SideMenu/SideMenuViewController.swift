//
//  SideMenuViewController.swift
//  TripNN
//
//  Created by Pavel on 26.02.2024.
//

import UIKit

final class SideMenuViewController: UIViewController {
    
    // MARK: - View
    
    weak var sideMenuView: SideMenuView? {
        return self.view as? SideMenuView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func loadView() {
        self.view = SideMenuView(frame: UIScreen.main.bounds)
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupActions()
    }
    
    private func setupActions() {
        sideMenuView?.onSideMenuButtonCloseAction = { [weak self] in self?.sideMenuCloseAction() }
    }
    
    // MARK: - Action
    
    @objc private func sideMenuCloseAction() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
