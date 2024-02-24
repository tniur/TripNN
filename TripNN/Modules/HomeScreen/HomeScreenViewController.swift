//
//  HomeScreenViewController.swift
//  TripNN
//
//  Created by Pavel on 30.01.2024.
//

import UIKit

final class HomeScreenViewController: UIViewController {
    
    // MARK: - View
    
    weak var homeScreenView: HomeScreenView? {
        return self.view as? HomeScreenView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupActions()
    }
    
    override func loadView() {
        self.view = HomeScreenView(frame: UIScreen.main.bounds)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBarStyle(isHidden: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setupNavigationBarStyle(isHidden: false)
    }
    
    // MARK: - Styles
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    private func setupNavigationBarStyle(isHidden: Bool) {
        navigationController?.navigationBar.isHidden = isHidden
        navigationItem.backButtonTitle = ""
    }
    
    // MARK: - Actions
    
    private func setupActions() {
        homeScreenView?.onSideMenuButtonAction = { [weak self] in self?.sideMenuAction() }
        homeScreenView?.onNewRouteButtonAction = { [weak self] in self?.createNewRoute() }
        homeScreenView?.onAllPreparedRoutesButtonAction = { [weak self] in self?.openAllPreparedRoutes() }
    }
    
    @objc private func sideMenuAction() {
        
    }
    
    @objc private func createNewRoute() {
        let controller = NewRouteSettingsViewController()
        navigationController?.pushViewController(controller, animated: true)
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc private func openAllPreparedRoutes() {
        let controller = AllPreparedRoutesViewController()
        navigationController?.pushViewController(controller, animated: true)
        navigationController?.navigationBar.tintColor = .black
    }
}
