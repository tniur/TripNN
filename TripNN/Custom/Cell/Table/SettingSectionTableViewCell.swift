//
//  SettingSectionTableViewCell.swift
//  TripNN
//
//  Created by Pavel on 29.02.2024.
//

import UIKit

final class SettingSectionTableViewCell: UITableViewCell {
    
    // MARK: - View
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let labelsContainerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont(name: "Montserrat-Regular", size: 16)
        label.textColor = .tripnnDark
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont(name: "Montserrat-Regular", size: 10)
        label.textColor = .tripnnDarkGray
        return label
    }()
    
    func changeColor() {
        titleLabel.textColor = .red
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(settingSectionModel: SettingSectionModel) {
        titleLabel.text = settingSectionModel.title
        statusLabel.text = settingSectionModel.status
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        contentView.addSubview(containerView)
        containerView.addSubview(labelsContainerStack)
        labelsContainerStack.addArrangedSubview(titleLabel)
        labelsContainerStack.addArrangedSubview(statusLabel)
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
        labelsContainerStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelsContainerStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            labelsContainerStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelsContainerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -17),
            labelsContainerStack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 17),
        ])
    }
}