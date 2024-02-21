//
//  ScreenTitleView.swift
//  TripNN
//
//  Created by Pavel on 20.02.2024.
//

import UIKit

class ScreenTitleLabel: UILabel {
    
    //MARK: - View
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .tripnnDark
        label.font =  UIFont(name: "Montserrat-SemiBold", size: 24)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        return label
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
    
    // MARK: - Configure
    
    func configure(title: String) {
        titleLabel.text = title
    }
    
    // MARK: - Setup
    
    private func setup() {
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            titleLabel.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
}
