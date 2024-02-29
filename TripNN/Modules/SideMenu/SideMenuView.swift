//
//  SideMenuViewController.swift
//  TripNN
//
//  Created by Pavel on 26.02.2024.
//

import UIKit

final class SideMenuView: UIView {
    
    var onSideMenuButtonCloseAction: (() -> Void)?
    
    // MARK: - View
    
    
    
    private let sideMenuCloseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close-icon"), for: .normal)
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
    
    private func setup() {
        setupView()
        setupConstrains()
        addActions()
    }
    
    private func setupView() {
        
        // sideMenuView.addSubview(sideMenuCloseButton)
    }
    
    // MARK: - Actions
    
    private func addActions() {
        sideMenuCloseButton.addTarget(self, action: #selector(closeSideMenu), for: .touchUpInside)
    }
    
    @objc private func closeSideMenu() {
        onSideMenuButtonCloseAction?()
    }
    
    // MARK: - Constrains
    
    private func setupConstrains() {

        setupSideMenuCloseButtonConstraints()
    }
    
    
    
    private func setupSideMenuCloseButtonConstraints() {
        sideMenuCloseButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sideMenuCloseButton.topAnchor.constraint(equalTo: topAnchor, constant: 64),
            sideMenuCloseButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            sideMenuCloseButton.widthAnchor.constraint(equalToConstant: 44),
            sideMenuCloseButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
