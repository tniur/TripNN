//
//  PlaceDetailsViewController.swift
//  TripNN
//
//  Created by Pavel on 23.02.2024.
//

import UIKit

final class PlaceDetailsViewController: UIViewController {
    
    // MARK: - View
    
    weak var placeDetailsView: PlaceDetailsView? {
        return self.view as? PlaceDetailsView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        self.view = PlaceDetailsView(frame: UIScreen.main.bounds)
    }
}
