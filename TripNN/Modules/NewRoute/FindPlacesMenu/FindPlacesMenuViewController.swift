//
//  FindPlacesMenuViewController.swift
//  TripNN
//
//  Created by Pavel on 11.03.2024.
//

import UIKit

final class FindPlacesMenuViewController: UIViewController {
    
    // MARK: - View
    
    weak var findPlacesMenuView: FindPlacesMenuView? {
        return self.view as? FindPlacesMenuView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func loadView() {
        self.view = FindPlacesMenuView(frame: UIScreen.main.bounds)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBarStyle(isHidden: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setupNavigationBarStyle(isHidden: false)
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupAction()
        setupNavigationBarStyle()
    }
    
    private func setupAction() {
        findPlacesMenuView?.onNextStepButtonAction = { [weak self] in self?.goToNextStepAction() }
    }
    
    private func setupNavigationBarStyle() {
        navigationItem.backButtonTitle = ""
    }
    
    // MARK: - Action
    
    @objc private func goToNextStepAction() {
        let controller = FindPlaceResultMenuViewController()
        navigationController?.pushViewController(controller, animated: true)
        navigationController?.navigationBar.tintColor = .tripnnDark
    }
    
    private func setupNavigationBarStyle(isHidden: Bool) {
        navigationController?.navigationBar.isHidden = isHidden
        navigationItem.backButtonTitle = ""
    }
}
