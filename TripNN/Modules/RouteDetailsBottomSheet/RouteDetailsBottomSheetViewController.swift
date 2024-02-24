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
    }
    
    override func loadView() {
        self.view = RouteDetailsBottomSheetView(frame: UIScreen.main.bounds)
    }
}
