//
//  SideMenuViewController.swift
//  TripNN
//
//  Created by Pavel on 26.02.2024.
//

import UIKit

final class SideMenuView: UIView {
    
    // MARK: - Closures
    
    var onSideMenuButtonCloseAction: (() -> Void)?
    
    // MARK: - Constants
    
    let sideMenuWidth = UIScreen.main.bounds.width / 1.5
    
    // MARK: - View
    
    let sideMenuBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()
    
    let sideMenuView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
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
        self.addSubview(sideMenuBackgroundView)
        self.addSubview(sideMenuView)
        sideMenuView.addSubview(sideMenuCloseButton)
    }
    
    private func setupConstrains() {
        setupSideMenuBackgroundViewConstraints()
        setupSideMenuViewConstraints()
        setupSideMenuCloseButtonConstraints()
    }
    
    // MARK: - Actions
    
    private func addActions() {
        sideMenuCloseButton.addTarget(self, action: #selector(closeSideMenu), for: .touchUpInside)
    }
    
    @objc private func closeSideMenu() {
        onSideMenuButtonCloseAction?()
    }
    
    // MARK: - Constrains
    
    private func setupSideMenuBackgroundViewConstraints() {
        sideMenuBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sideMenuBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            sideMenuBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            sideMenuBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            sideMenuBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setupSideMenuViewConstraints() {
        sideMenuView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sideMenuView.widthAnchor.constraint(equalToConstant: sideMenuWidth),
            sideMenuView.bottomAnchor.constraint(equalTo: bottomAnchor),
            sideMenuView.topAnchor.constraint(equalTo: topAnchor),
            sideMenuView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
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
