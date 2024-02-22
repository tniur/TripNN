//
//  NewTripSettings.swift
//  TripNN
//
//  Created by Pavel on 19.02.2024.
//

import UIKit

final class NewTripSettingsViewController: UIViewController {
    
    // MARK: - View
    
    weak var newTripSettingsView: NewTripSettingsView? {
        return self.view as? NewTripSettingsView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        self.view = NewTripSettingsView(frame: UIScreen.main.bounds)
    }

}
