//
//  ClipboardSavingNotification.swift
//  TripNN
//
//  Created by Pavel on 05.03.2024.
//

import UIKit

final class ClipboardSavingNotification: UIView {
    
    // MARK: - View
    
    private let notificationLabel: UILabel = {
        let label = UILabel()
        label.text = "Адрес скопирован"
        label.font = UIFont(name: "Montserrat-Medium", size: 14)
        label.textColor = .tripnnWhite
        return label
    }()
    
    private let notificationImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "info-icon")
        return image
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
    }
    
    private func setupView() {
        backgroundColor = .tripnnOrange
        layer.cornerRadius = 8
    
        addSubview(notificationImage)
        addSubview(notificationLabel)
    }
    
    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        setupNotificationImageConstraints()
        setupNotificationLabelConstraints()
    }
    
    // MARK: - Constraints
    
    private func setupNotificationImageConstraints() {
        notificationImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notificationImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            notificationImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
        ])
    }
    
    private func setupNotificationLabelConstraints() {
        notificationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notificationLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            notificationLabel.leadingAnchor.constraint(equalTo: notificationImage.trailingAnchor, constant: 10),
        ])
    }
}
