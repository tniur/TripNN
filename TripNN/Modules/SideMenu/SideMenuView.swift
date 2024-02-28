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
    
    private let sideMenuView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let sideMenuContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .tripnnWhite
        return view
    }()
    
    private let sideMenuShadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.opacity = 0.5
        
        return view
    }()
    
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
        self.addSubview(sideMenuView)
        sideMenuView.addSubview(sideMenuContentView)
        // sideMenuView.addSubview(sideMenuShadowView)
        sideMenuContentView.addSubview(sideMenuCloseButton)
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
        setupSideMenuConstraints()
        setupSideMenuContentViewConstraints()
        // setupSideMenuShadowViewConstraints()
        setupSideMenuCloseButtonConstraints()
    }
    
    private func setupSideMenuConstraints() {
        sideMenuView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sideMenuView.topAnchor.constraint(equalTo: topAnchor),
            sideMenuView.bottomAnchor.constraint(equalTo: bottomAnchor),
            sideMenuView.leadingAnchor.constraint(equalTo: leadingAnchor),
            sideMenuView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setupSideMenuContentViewConstraints() {
        sideMenuContentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sideMenuContentView.topAnchor.constraint(equalTo: topAnchor),
            sideMenuContentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            sideMenuContentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            sideMenuContentView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setupSideMenuShadowViewConstraints() {
        sideMenuShadowView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sideMenuShadowView.topAnchor.constraint(equalTo: topAnchor),
            sideMenuShadowView.bottomAnchor.constraint(equalTo: bottomAnchor),
            sideMenuShadowView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: self.bounds.width*0.8),
            sideMenuShadowView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setupSideMenuCloseButtonConstraints() {
        sideMenuCloseButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sideMenuCloseButton.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            sideMenuCloseButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            sideMenuCloseButton.widthAnchor.constraint(equalToConstant: 44),
            sideMenuCloseButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
