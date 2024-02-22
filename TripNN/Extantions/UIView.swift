//
//  View.swift
//  TripNN
//
//  Created by Pavel on 15.02.2024.
//

import UIKit

extension UIView {
    func addViewShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 6.0
    }
}
