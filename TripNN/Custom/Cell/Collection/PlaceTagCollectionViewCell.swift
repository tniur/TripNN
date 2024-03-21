//
//  PlaceTagCollectionViewCell.swift
//  TripNN
//
//  Created by Pavel on 16.03.2024.
//

import UIKit

final class PlaceTagCollectionViewCell: UICollectionViewCell {
    
    // MARK: - View
    
    private let cellLabel = Title(font: .medium, size: 14, color: .tripnnSemiDark)

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Configure

    func configure(title: String) {
        cellLabel.text = title
        cellLabel.sizeToFit()
    }
    
    // MARK: - Setup

    private func setup() {
        backgroundColor = .tripnnLightGray
        layer.cornerRadius = 25

        contentView.addSubview(cellLabel)
        
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            cellLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            cellLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cellLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
}
