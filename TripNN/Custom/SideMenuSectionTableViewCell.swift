//
//  SideMenuTableViewCell.swift
//  TripNN
//
//  Created by Pavel on 29.02.2024.
//

import UIKit

final class SideMenuSectionTableViewCell: UITableViewCell {
    
    // MARK: - View
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let sectionButton: UILabel = {
        let label = UILabel()
        label.textColor = .tripnnDark
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        return label
    }()
    
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
        sectionButton.text = title
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        contentView.addSubview(containerView)
        containerView.addSubview(sectionButton)
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
        sectionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sectionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            sectionButton.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            sectionButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}
