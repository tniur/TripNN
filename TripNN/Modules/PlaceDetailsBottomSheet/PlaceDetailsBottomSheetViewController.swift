//
//  PlaceDetailsBottomSheetViewController.swift
//  TripNN
//
//  Created by Pavel on 23.02.2024.
//

import UIKit

final class PlaceDetailsBottomSheetViewController: UIViewController {
    // MARK: - View
    
    weak var placeDetailsBottomSheetView: PlaceDetailsBottomSheetView? {
        return self.view as? PlaceDetailsBottomSheetView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        self.view = PlaceDetailsBottomSheetView(frame: UIScreen.main.bounds)
    }
}
