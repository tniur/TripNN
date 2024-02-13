//
//  ViewController.swift
//  TripNN
//
//  Created by Pavel on 30.01.2024.
//

import UIKit

final class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // MARK: - Top Stack
        
        let topPartStack = UIStackView()
        topPartStack.backgroundColor = .tripnnYellow
        topPartStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topPartStack)
        NSLayoutConstraint.activate ([
            topPartStack.topAnchor.constraint(equalTo: view.topAnchor),
            topPartStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topPartStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topPartStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height / 2)
        ])
        
        
        // MARK: - Header
        
        let headerStack = UIStackView()
        headerStack.translatesAutoresizingMaskIntoConstraints = false
        topPartStack.addSubview(headerStack)
        NSLayoutConstraint.activate ([
            headerStack.topAnchor.constraint(equalTo: view.topAnchor),
            headerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        // MARK: - Logo
        let logoImage = UIImageView(image: UIImage(named: "logo_dark"))
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        headerStack.addSubview(logoImage)
        NSLayoutConstraint.activate ([
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 72)
        ])
        
        // MARK: - Side Menu Button
        
        let sideMenuButton = UIButton.systemButton(with: UIImage(named: "side_menu")!, target: self, action: #selector(self.didTapSideMenuButton))
        sideMenuButton.translatesAutoresizingMaskIntoConstraints = false
        headerStack.addSubview(sideMenuButton)
        sideMenuButton.tintColor = .tripnnDark
        NSLayoutConstraint.activate ([
            sideMenuButton.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor),
            sideMenuButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            sideMenuButton.widthAnchor.constraint(equalToConstant: 44),
            sideMenuButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // MARK: - All Place Button
        let allPlaceButton = UIButton()
        allPlaceButton.translatesAutoresizingMaskIntoConstraints = false
        topPartStack.addSubview(allPlaceButton)
        
        allPlaceButton.layer.masksToBounds = false
        allPlaceButton.backgroundColor = .tripNNWhite
        allPlaceButton.layer.cornerRadius = 6
        allPlaceButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        allPlaceButton.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        allPlaceButton.layer.shadowOpacity = 5.0
        allPlaceButton.layer.shadowRadius = 8.0
        
        NSLayoutConstraint.activate ([
            allPlaceButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            allPlaceButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            allPlaceButton.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 14),
            allPlaceButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        // MARK: - All Place Label
        
        let allPlaceButtonLabel = UILabel()
        allPlaceButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        allPlaceButtonLabel.text = "Все места Нижнего Новгорода"
        allPlaceButtonLabel.font = UIFont(name: "Montserrat", size: 14.0)
        allPlaceButtonLabel.textColor = .tripnnDark
        
        
        // MARK: - All Place Icon
        
        let allPlaceButtonIcon = UIImageView(image: UIImage(named: "all-place-button"))
        allPlaceButtonIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            allPlaceButtonIcon.widthAnchor.constraint(equalToConstant: 18),
            allPlaceButtonIcon.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        // MARK: - All Place Button Stack
        
        let placeButtonContentStack = UIStackView(arrangedSubviews: [allPlaceButtonIcon, allPlaceButtonLabel])
        placeButtonContentStack.translatesAutoresizingMaskIntoConstraints = false
        allPlaceButton.addSubview(placeButtonContentStack)
        placeButtonContentStack.spacing = 12
        placeButtonContentStack.axis = .horizontal
        placeButtonContentStack.alignment = .center
        placeButtonContentStack.distribution = .equalCentering
        
        NSLayoutConstraint.activate ([
            placeButtonContentStack.trailingAnchor.constraint(equalTo: allPlaceButton.trailingAnchor),
            placeButtonContentStack.leadingAnchor.constraint(equalTo: allPlaceButton.leadingAnchor),
            placeButtonContentStack.topAnchor.constraint(equalTo: allPlaceButton.topAnchor),
            placeButtonContentStack.bottomAnchor.constraint(equalTo: allPlaceButton.bottomAnchor),
        ])
        
        
        // MARK: - Bottom Stack
        
        let bottomPartStack = UIStackView()
        bottomPartStack.backgroundColor = .tripNNWhite
        bottomPartStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomPartStack)
        
        NSLayoutConstraint.activate ([
            bottomPartStack.topAnchor.constraint(equalTo: topPartStack.bottomAnchor),
            bottomPartStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomPartStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomPartStack.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    // MARK: - Private Functions
    
    @objc private func didTapSideMenuButton() {
        
    }
    
}
