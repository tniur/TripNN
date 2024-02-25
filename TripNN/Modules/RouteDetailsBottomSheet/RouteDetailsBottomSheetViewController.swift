//
//  RouteDetailsBottomSheetViewController.swift
//  TripNN
//
//  Created by Pavel on 22.02.2024.
//

import UIKit

final class RouteDetailsBottomSheetViewController: UIViewController {
    // MARK: - View
    
    weak var routeDetailsBottomSheetView: RouteDetailsBottomSheetView? {
        return self.view as? RouteDetailsBottomSheetView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func loadView() {
        self.view = RouteDetailsBottomSheetView(frame: UIScreen.main.bounds)
    }
    
    // MARK: Setup
    
    private func setup() {
        setupActions()
    }
    
    private func setupActions() {
        routeDetailsBottomSheetView?.onSelectTableCellAction = { [weak self] in self?.openPlaceDetailsBottomSheetViewController() }
    }
    
    // MARK: Action
    
    private func openPlaceDetailsBottomSheetViewController() {
        let bottomSheet = PlaceDetailsBottomSheetViewController()
        if let sheet = bottomSheet.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        present(bottomSheet, animated: true)
    }
}
