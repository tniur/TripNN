//
//  ItemCardBottomSheetViewController.swift
//  TripNN
//
//  Created by Pavel on 22.02.2024.
//

import UIKit

final class ItemCardBottomSheetViewController: UIViewController {
    // MARK: - View
    
    weak var itemCardBottomSheetView: ItemCardBottomSheetView? {
        return self.view as? ItemCardBottomSheetView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        self.view = ItemCardBottomSheetView(frame: UIScreen.main.bounds)
    }
}
