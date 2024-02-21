//
//  NewTripSettingsView.swift
//  TripNN
//
//  Created by Pavel on 19.02.2024.
//

import UIKit

class NewTripSettingsView: UIView {
    
    // MARK: - Closures
    
    var onNavigationBackButtonAction: (() -> Void)?
    
    // MARK: - View
    
    private let navigationBackButton: NavigationBackButton = {
        let button = NavigationBackButton()
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
    
    // MARK: - Action
    
    @objc private func navigationBackButtonAction() {
        onNavigationBackButtonAction?()
    }
    
    // MARK: - Setup
    
    private func setup() {
        self.backgroundColor = .white
        setupView()
        setupConstraints()
        setupAction()
    }
    
    private func setupView() {
        self.addSubview(navigationBackButton)
    }
    
    private func setupConstraints() {
        setupNavigationBackButtonConstraints()
    }
    
    private func setupAction() {
        navigationBackButton.setupAction(target: self, buttonAction: #selector(navigationBackButtonAction))
    }
    
    private func setupNavigationBackButtonConstraints() {
        navigationBackButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationBackButton.widthAnchor.constraint(equalToConstant: 44),
            navigationBackButton.heightAnchor.constraint(equalToConstant: 44),
            navigationBackButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            navigationBackButton.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
}
