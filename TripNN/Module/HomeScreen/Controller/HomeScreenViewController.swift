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
        
        setActions()
    }
    
    override func loadView() {
        self.view = HomeScreenView(frame: UIScreen.main.bounds)
    }
    
    // MARK: - Styles
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    // MARK: - Actions
    
    private func setActions() {
        homeScreenView?.onOpeningSideMenuButtonAction = { [weak self] in self?.sideMenuAction() }
        homeScreenView?.onNewTripButtonAction = { [weak self] in self?.createNewTrip() }
    }
    
    @objc private func sideMenuAction() {
        print("HELLO")
    }
    
    @objc private func createNewTrip() {
        print("HELLO")
    }
 
}
