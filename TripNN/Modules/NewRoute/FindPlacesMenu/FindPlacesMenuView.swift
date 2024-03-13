//
//  FindPlacesMenuView.swift
//  TripNN
//
//  Created by Pavel on 11.03.2024.
//

import UIKit

final class FindPlacesMenuView: UIView {
    
    // MARK: - Closures
    
    var onNextStepButtonAction: (() -> Void)?

    // MARK: - View
    
    private let nextStepButton = BigButton(withTitle: String(localized: "next_step"))
    
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
        self.backgroundColor = .white
        setupView()
        setupConstraints()
        addAction()
    }
    
    private func setupView() {
        self.addSubview(nextStepButton)
    }
    
    private func setupConstraints() {
        setupNextStepButtonConstraints()
    }
    
    private func addAction() {
        nextStepButton.addTarget(self, action: #selector(nextStepButtonAction), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func nextStepButtonAction() {
        onNextStepButtonAction?()
    }
    
    // MARK: - Constraints
    
    private func setupNextStepButtonConstraints() {
        nextStepButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextStepButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextStepButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40)
        ])
    }
    
}
