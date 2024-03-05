//
//  FullScreenImageView.swift
//  TripNN
//
//  Created by Pavel on 04.03.2024.
//

import UIKit

class FullScreenImageView: UIView {
    
    // MARK: - Closures
    
    var onCloseButtonAction: (() -> Void)?
    
    // MARK: - View
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Закрыть", for: .normal)
        button.titleLabel?.font =  UIFont(name: "Montserrat-Regular", size: 16)
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
        self.backgroundColor = .black
        setupView()
        setupConstraints()
        setupAction()
    }
    
    private func setupView() {
        self.addSubview(closeButton)
    }
    
    private func setupConstraints() {
        setupCloseButtonConstraints()
    }
    
    private func setupAction() {
        closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
    }
    
    // MARK: - Action
    
    @objc private func closeButtonAction() {
        onCloseButtonAction?()
    }
    
    // MARK: - Constraints
    
    private func setupCloseButtonConstraints() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
    }
    
}
