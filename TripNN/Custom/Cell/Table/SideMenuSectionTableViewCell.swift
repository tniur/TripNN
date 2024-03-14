//
//  SideMenuTableViewCell.swift
//  TripNN
//
//  Created by Pavel on 29.02.2024.
//

import UIKit

final class SideMenuSectionTableViewCell: UITableViewCell {
    
    // MARK: - View
    
    private let containerView = UIView()
    
    private let sectionLabel = Title(text: "none", font: .regular, size: 16)
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    func configure(title: String) {
        sectionLabel.text = title
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        contentView.addSubview(containerView)
        containerView.addSubview(sectionLabel)
    }
    
    private func setupConstraints() {
        setupContainerViewConstraints()
        setupLabelsContainerViewConstraints()
    }
    
    private func setupContainerViewConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = containerView.heightAnchor.constraint(equalToConstant: 70)
        heightConstraint.priority = UILayoutPriority(999)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            heightConstraint
        ])
    }
    
    private func setupLabelsContainerViewConstraints() {
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            sectionLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            sectionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}
