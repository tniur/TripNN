//
//  BigButton.swift
//  TripNN
//
//  Created by Pavel on 11.03.2024.
//

import UIKit

final class BigButton: UIButton {
    
    // MARK: - Init
    
    init(withTitle title: String) {
        super.init(frame: .zero)
        
        setup(title)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setup
    
    private func setup(_ title: String) {
        
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .tripnnOrange
        configuration.cornerStyle = .capsule
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 60, bottom: 18, trailing: 60)
        configuration.attributedTitle = AttributedString(title, attributes: AttributeContainer([NSAttributedString.Key.font: UIFont(name: "Montserrat-Semibold", size: 16)!]))
        
        self.configuration = configuration
        addViewShadow()
    }
}
