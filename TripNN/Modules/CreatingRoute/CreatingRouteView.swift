//
//  CreatingRouteView.swift
//  TripNN
//
//  Created by Pavel on 19.02.2024.
//

import UIKit

class CreatingRouteView: UIView {
    
    // MARK: - View
    
    private let addPlaceButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus-icon"), for: .normal)
        button.setTitle("Добавить место", for: .normal)
        button.titleLabel?.font =  UIFont(name: "Montserrat-Medium", size: 16)
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 6
        button.setTitleColor(.tripnnWhite, for: .normal)
        button.backgroundColor = .tripnnOrange
        button.contentHorizontalAlignment = .left
        button.addViewShadow()
        button.setInsets(forContentPadding: UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 13), imageTitlePadding: 13)
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
        self.backgroundColor = .white
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        self.addSubview(addPlaceButton)
    }
    
    private func setupConstraints() {
        setupAddPlaceButtonConstraints()
    }
    
    private func setupAddPlaceButtonConstraints() {
        addPlaceButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            addPlaceButton.topAnchor.constraint(equalTo: topAnchor, constant: 300),
            addPlaceButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            addPlaceButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            addPlaceButton.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
}
