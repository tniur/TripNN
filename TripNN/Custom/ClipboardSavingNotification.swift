//
//  ClipboardSavingNotification.swift
//  TripNN
//
//  Created by Pavel on 05.03.2024.
//

import UIKit

final class ClipboardSavingNotification: UIView {
    
    // MARK: - View
    
    private let notificationBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .tripnnOrange
        view.layer.cornerRadius = 8
        return view
    }()
    
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
        self.addSubview(notificationBackground)
        self.addSubview(notificationImage)
        self.addSubview(notificationLabel)
    }
    
    private func setupConstraints() {
        setupNotificationBackgroundConstraints()
        setupNotificationImageConstraints()
        setupNotificationLabelConstraints()
    }
    
    // MARK: - Constraints
    
    private func setupNotificationBackgroundConstraints(){
        notificationBackground.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notificationBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            notificationBackground.bottomAnchor.constraint(equalTo: bottomAnchor),
            notificationBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            notificationBackground.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    private func setupNotificationImageConstraints(){
        notificationImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notificationImage.centerYAnchor.constraint(equalTo: notificationBackground.centerYAnchor),
            notificationImage.leadingAnchor.constraint(equalTo: notificationBackground.leadingAnchor, constant: 10),
        ])
    }
    
    private func setupNotificationLabelConstraints(){
        notificationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notificationLabel.centerYAnchor.constraint(equalTo: notificationBackground.centerYAnchor),
            notificationLabel.leadingAnchor.constraint(equalTo: notificationImage.trailingAnchor, constant: 10),
        ])
    }
    
}
