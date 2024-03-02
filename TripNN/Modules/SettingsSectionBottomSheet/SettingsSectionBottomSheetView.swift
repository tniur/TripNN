//
//  SettingsSectionBottomSheetView.swift
//  TripNN
//
//  Created by Pavel on 02.03.2024.
//

import UIKit

final class SettingsSectionBottomSheetView: UIView {
    
    // MARK: - Closures
    
    var onCloseButtonAction: (() -> Void)?
    
    // MARK: - View
    
    private let sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 18)
        label.textColor = .tripnnDark
        label.text = "Тема"
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "gray-close-icon"), for: .normal)
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
        setupConstraints()
        setupActions()
    }
    
    private func setupView() {
        self.backgroundColor = .tripnnWhite
        self.addSubview(sectionTitleLabel)
        self.addSubview(closeButton)
    }
    
    private func setupConstraints() {
        setupSectionTitleLabelConstraints()
        setupCloseButtonConstraints()
    }
    
    private func setupActions() {
        closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func closeButtonAction() {
        onCloseButtonAction?()
    }
    
    // MARK: - Constraints
    
    private func setupSectionTitleLabelConstraints() {
        sectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sectionTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            sectionTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20)
        ])
    }
    
    private func setupCloseButtonConstraints() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.centerYAnchor.constraint(equalTo: sectionTitleLabel.centerYAnchor),
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            closeButton.widthAnchor.constraint(equalToConstant: 44),
            closeButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
