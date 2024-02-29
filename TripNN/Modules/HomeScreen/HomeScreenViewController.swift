//
//  HomeScreenViewController.swift
//  TripNN
//
//  Created by Pavel on 30.01.2024.
//

import UIKit

final class HomeScreenViewController: UIViewController {
    
    var isSideMenuPresent:  Bool = false
    
    // MARK: - View
    
    weak var homeScreenView: HomeScreenView? {
        return self.view as? HomeScreenView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
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
    
    private func setup() {
        setupActions()
    }
    
    private func setupActions() {
        homeScreenView?.onSideMenuButtonAction = { [weak self] in self?.sideMenuOpenAction() }
        homeScreenView?.onNewRouteButtonAction = { [weak self] in self?.createNewRoute() }
        homeScreenView?.onAllPreparedRoutesButtonAction = { [weak self] in self?.openAllPreparedRoutes() }
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
    
    @objc private func createNewRoute() {
        let controller = CreatingRouteViewController()
        navigationController?.pushViewController(controller, animated: true)
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc private func openAllPreparedRoutes() {
        let controller = AllPreparedRoutesViewController()
        navigationController?.pushViewController(controller, animated: true)
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc private func sideMenuOpenAction() {
        let sideMenuViewController = SideMenuViewController()
        sideMenuViewController.modalPresentationStyle = .custom
        present(sideMenuViewController, animated: true, completion: nil)
    }
}
