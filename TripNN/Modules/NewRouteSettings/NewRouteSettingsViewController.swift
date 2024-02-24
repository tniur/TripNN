//
//  NewRouteSettings.swift
//  TripNN
//
//  Created by Pavel on 19.02.2024.
//

import UIKit

final class NewRouteSettingsViewController: UIViewController {
    
    // MARK: - View
    
    weak var newRouteSettingsView: NewRouteSettingsView? {
        return self.view as? NewRouteSettingsView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        self.view = NewRouteSettingsView(frame: UIScreen.main.bounds)
    }

}
