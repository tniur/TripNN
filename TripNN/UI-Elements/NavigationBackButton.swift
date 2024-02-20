//
//  NavigationBackButton.swift
//  TripNN
//
//  Created by Pavel on 19.02.2024.
//

import UIKit

final class NavigationBackButton: UIView {
    
    // MARK: - Views
    
    let navigationBackButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "navigation-back-icon"), for: .normal)
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Setup
    
    func setupAction(target: Any?, buttonAction: Selector) {
        navigationBackButton.addTarget(target, action: buttonAction, for: .touchUpInside)
    }
    
    private func setup() {
        addSubview(navigationBackButton)
        setupConstrains()
    }
    
    // MARK: - Constrains
    
    private func setupConstrains() {
        navigationBackButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationBackButton.widthAnchor.constraint(equalToConstant: 44),
            navigationBackButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
}
