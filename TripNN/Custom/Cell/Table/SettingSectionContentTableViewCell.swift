//
//  SettingSectionContentTableViewCell.swift
//  TripNN
//
//  Created by Pavel on 03.03.2024.
//

import UIKit

final class SettingSectionContentTableViewCell: UITableViewCell {
    
    // MARK: - View
    
    private let containerView = UIView()
    
    private let cellLabel = Title(text: "none", font: .regular, size: 18)
    
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
        cellLabel.text = title
    }
    
    func setSelectCellStyle() {
        containerView.backgroundColor = .tripnnOrange
        cellLabel.textColor = .tripnnWhite
        cellLabel.font = UIFont(name: "Montserrat-Medium", size: 18)
    }
    
    func setUnSelectCellStyle() {
        containerView.backgroundColor = .tripnnWhite
        cellLabel.textColor = .tripnnDark
        cellLabel.font = UIFont(name: "Montserrat-Regular", size: 18)
    }
    
    func setFirstCellStyle() {
        containerView.backgroundColor = .tripnnWhite
        containerView.layer.cornerRadius = 20
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        cellLabel.font = UIFont(name: "Montserrat-Regular", size: 18)
        cellLabel.textColor = .tripnnDark
    }
    
    func setLastCellStyle() {
        containerView.backgroundColor = .tripnnWhite
        containerView.layer.cornerRadius = 20
        containerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        cellLabel.font = UIFont(name: "Montserrat-Regular", size: 18)
        cellLabel.textColor = .tripnnDark
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        contentView.addSubview(containerView)
        containerView.addSubview(cellLabel)
    }
    
    private func setupConstraints() {
        setupContainerViewConstraints()
        setupLabelsContainerViewConstraints()
    }
    
    private func setupContainerViewConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = containerView.heightAnchor.constraint(equalToConstant: 65)
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
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            cellLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            cellLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}
