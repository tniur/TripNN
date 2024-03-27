//
//  TagCollectionSectionHeader.swift
//  TripNN
//
//  Created by Pavel on 26.03.2024.
//

import UIKit

final class TagCollectionSectionHeader: UICollectionReusableView {
    
    static let reuseId = "TagCollectionSectionHeader"
    
    // MARK: - View
    
    private let headerTitle = Title(font: .medium, size: 16)
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    func configure(text: String) {
        headerTitle.text = text
    }
    
    // MARK: - Setup
    
    private func setup() {
        addSubview(headerTitle)
        
        let bottomConstraint = headerTitle.bottomAnchor.constraint(equalTo: bottomAnchor)
        bottomConstraint.priority = UILayoutPriority(999)
        
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerTitle.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            bottomConstraint
        ])
    }
}
