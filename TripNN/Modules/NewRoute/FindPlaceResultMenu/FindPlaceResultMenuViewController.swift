//
//  FindPlaceResultMenuViewController.swift
//  TripNN
//
//  Created by Pavel on 11.03.2024.
//

import UIKit

final class FindPlaceResultMenuViewController: UIViewController {
    
    // MARK: - View
    
    weak var findPlaceResultMenuView: FindPlaceResultMenuView? {
        return self.view as? FindPlaceResultMenuView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func loadView() {
        self.view = FindPlaceResultMenuView(frame: UIScreen.main.bounds)
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupAction()
        setupNavigationBarStyle()
    }
    
    private func setupAction() {

    }
    
    private func setupNavigationBarStyle() {
        navigationController?.navigationBar.tintColor = .tripnnDark
    }
    
    // MARK: - Action
    
    @objc private func goToNextStepAction() {
        let controller = PlaceFiltersMenuViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
