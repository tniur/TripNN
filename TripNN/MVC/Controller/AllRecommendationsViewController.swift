//
//  AllRecommendationViewController.swift
//  TripNN
//
//  Created by Pavel on 20.02.2024.
//

import UIKit

class AllRecommendationsViewController: UIViewController {

    // MARK: - View
    
    weak var allRecommendationsView: AllRecommendationsView? {
        return self.view as? AllRecommendationsView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAction()
    }
    
    override func loadView() {
        self.view = AllRecommendationsView(frame: UIScreen.main.bounds)
    }
    
    // MARK: - Action
    
    private func setupAction() {
        allRecommendationsView?.onNavigationBackButtonAction = { [weak self] in self?.navigationBackButtonAction() }
    }
    
    @objc private func navigationBackButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
}
