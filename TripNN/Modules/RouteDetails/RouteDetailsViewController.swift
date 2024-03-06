//
//  RouteDetailsViewController.swift
//  TripNN
//
//  Created by Pavel on 22.02.2024.
//

import UIKit

final class RouteDetailsViewController: UIViewController {
    
    // MARK: - View
    
    weak var routeDetailsView: RouteDetailsView? {
        return self.view as? RouteDetailsView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func loadView() {
        self.view = RouteDetailsView(frame: UIScreen.main.bounds)
    }
    
    // MARK: Setup
    
    private func setup() {
        setupActions()
    }
    
    private func setupActions() {
        routeDetailsView?.onSelectTableCellAction = { [weak self] in self?.openPlaceDetailsViewController() }
    }
    
    // MARK: Action
    
    private func openPlaceDetailsViewController() {
        let bottomSheet = PlaceDetailsViewController()
        if let sheet = bottomSheet.sheetPresentationController {
            if #available(iOS 16.0, *) {
                sheet.detents = [.custom(resolver: {context in 0.43 * context.maximumDetentValue}), .large()]
            } else {
                sheet.detents = [.medium(), .large()]
            }
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.preferredCornerRadius = 20
            sheet.prefersGrabberVisible = true
        }
        present(bottomSheet, animated: true)
    }
}
