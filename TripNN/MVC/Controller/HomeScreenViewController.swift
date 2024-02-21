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
        setupNavigationBarStyle()
        
    }
    
    override func loadView() {
        self.view = HomeScreenView(frame: UIScreen.main.bounds)
    }
    
    // MARK: - Styles
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    private func setupNavigationBarStyle() {
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Actions
    
    private func setupActions() {
        homeScreenView?.onOpeningSideMenuButtonAction = { [weak self] in self?.sideMenuAction() }
        homeScreenView?.onNewTripButtonAction = { [weak self] in self?.createNewTrip() }
        homeScreenView?.onAllRecommendationsButtonAction = { [weak self] in self?.openAllRecommendations() }
    }
    
    @objc private func sideMenuAction() {

    }
    
    @objc private func createNewTrip() {
        let controller = NewTripSettingsViewController()
        navigationController?.pushViewController(controller, animated: true)
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc private func openAllRecommendations() {
        let controller = AllRecommendationsViewController()
        navigationController?.pushViewController(controller, animated: true)
        navigationController?.navigationBar.tintColor = .black
    }
 
}
