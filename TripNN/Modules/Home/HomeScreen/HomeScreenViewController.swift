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
    
    private func setup() {
        setupActions()
        setupGestures()
        setupNavigationBarStyle()
    }
    
    private func setupActions() {
        homeScreenView?.onSideMenuButtonAction = { [weak self] in self?.sideMenuOpenAction() }
        homeScreenView?.onNewRouteButtonAction = { [weak self] in self?.createNewRoute() }
        homeScreenView?.onAllPreparedRoutesButtonAction = { [weak self] in self?.openAllPreparedRoutes() }
    }
    
    private func setupGestures() {
        let edgePanRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.handleEdgePanGesture))
        edgePanRecognizer.edges = .left
        view.addGestureRecognizer(edgePanRecognizer)
    }
    
    @objc private func handleEdgePanGesture(sender: UIScreenEdgePanGestureRecognizer) {
        sideMenuOpenAction()
    }
    
    // MARK: - Styles
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    private func setupNavigationBarStyle() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "side-menu-icon"), style: .done, target: self, action: #selector(sideMenuOpenAction))
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .tripnnDark
        navigationItem.largeTitleDisplayMode = .never
        
        let logoImage = UIImageView(image: UIImage(named: "logo-dark-icon"))
        logoImage.contentMode = .scaleAspectFit
        navigationItem.titleView = logoImage
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
        sideMenuViewController.onSideMenuSettingsButtonAction = { [weak self] in
            sideMenuViewController.sideMenuCloseAction(animated: true)
            let controller = SettingsScreenViewController()
            self?.navigationController?.pushViewController(controller, animated: true)
            self?.navigationController?.navigationBar.tintColor = .black }
    }
}
