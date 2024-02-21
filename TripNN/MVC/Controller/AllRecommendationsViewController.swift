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
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .tripnnDark
        label.font =  UIFont(name: "Montserrat-SemiBold", size: 12)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        label.text = "Рекомендованные маршруты"
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAction()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = allRecommendationsView?.searchController
        
        navigationController?.navigationBar.tintColor = .tripnnDark
        
        navigationItem.title = "Рекомендованные"
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "Montserrat-SemiBold", size: 10)!, NSAttributedString.Key.foregroundColor: UIColor.green]
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
