//
//  SegmentedControl.swift
//  TripNN
//
//  Created by Pavel on 14.03.2024.
//

import UIKit

class SegmentedControl: UISegmentedControl {

    // MARK: - Init
    
    override init(items: [Any]?) {
        super.init(items: items)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setup
    
    private func setup() {
        selectedSegmentIndex = 0
        backgroundColor = .tripnnLightGray
        selectedSegmentTintColor = .tripnnOrange
        
        setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Montserrat-Medium", size: 14)!, NSAttributedString.Key.foregroundColor:  UIColor.tripnnGray], for: .normal)
        
        setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Montserrat-SemiBold", size: 14)!, NSAttributedString.Key.foregroundColor:  UIColor.tripnnWhite], for: .selected)
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
