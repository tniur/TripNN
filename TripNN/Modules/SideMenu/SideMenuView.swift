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
    var onSideMenuSettingsButtonAction: (() -> Void)?
    
    // MARK: - Constants
    
    let sideMenuWidth = UIScreen.main.bounds.width / 1.5
    
    // MARK: - View
    
    let sideMenuBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()
    
    let sideMenuСontentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let sideMenuCloseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close-icon"), for: .normal)
        return button
    }()
    
    private let sideMenuButtonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 25
        return stack
    }()
    
    private let settingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Настройки", for: .normal)
        button.titleLabel?.font =  UIFont(name: "Montserrat-Regular", size: 18)
        button.layer.masksToBounds = false
        button.backgroundColor = .yellow
        button.setTitleColor(.tripnnDark, for: .normal)
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
        setupStack()
    }
    
    private func setupView() {
        self.addSubview(sideMenuBackgroundView)
        self.addSubview(sideMenuСontentView)
        sideMenuСontentView.addSubview(sideMenuCloseButton)
        sideMenuСontentView.addSubview(sideMenuButtonsStack)
    }
    
    private func setupStack() {
        sideMenuButtonsStack.addArrangedSubview(createSideMenuContentButton(title: "Аккаунт"))
        sideMenuButtonsStack.addArrangedSubview(createSideMenuContentButton(title: "История"))
        sideMenuButtonsStack.addArrangedSubview(createSideMenuContentButton(title: "Избранные"))
        sideMenuButtonsStack.addArrangedSubview(settingButton)
    }
    
    private func setupConstrains() {
        setupSideMenuBackgroundViewConstraints()
        setupSideMenuViewConstraints()
        setupSideMenuCloseButtonConstraints()
        setupSideMenuButtonsStackConstraints()
    }
    
    // MARK: - Actions
    
    private func addActions() {
        sideMenuCloseButton.addTarget(self, action: #selector(closeSideMenu), for: .touchUpInside)
        settingButton.addTarget(self, action: #selector(openSettingScreen), for: .touchUpInside)
    }
    
    @objc private func closeSideMenu() {
        onSideMenuButtonCloseAction?()
    }
    
    @objc private func openSettingScreen() {
        onSideMenuSettingsButtonAction?()
    }
    
    private func createSideMenuContentButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font =  UIFont(name: "Montserrat-Regular", size: 18)
        button.layer.masksToBounds = false
        button.setTitleColor(.tripnnDark, for: .normal)
        return button
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
        sideMenuСontentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sideMenuСontentView.widthAnchor.constraint(equalToConstant: sideMenuWidth),
            sideMenuСontentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            sideMenuСontentView.topAnchor.constraint(equalTo: topAnchor),
            sideMenuСontentView.leadingAnchor.constraint(equalTo: leadingAnchor)
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
    
    private func setupSideMenuButtonsStackConstraints() {
        sideMenuButtonsStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sideMenuButtonsStack.topAnchor.constraint(equalTo: sideMenuCloseButton.bottomAnchor, constant: 20),
            sideMenuButtonsStack.leadingAnchor.constraint(equalTo: sideMenuСontentView.leadingAnchor, constant: 26),
            sideMenuButtonsStack.trailingAnchor.constraint(equalTo: sideMenuСontentView.trailingAnchor, constant: 10),
            sideMenuButtonsStack.bottomAnchor.constraint(lessThanOrEqualTo: sideMenuСontentView.bottomAnchor, constant: 0)
        ])
    }
}
