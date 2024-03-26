//
//  PlaceTagCollectionViewCell.swift
//  TripNN
//
//  Created by Pavel on 16.03.2024.
//

import UIKit

enum PlaceTagCornerRadius: CGFloat {
    case light = 16
    case strong = 25
}

final class PlaceTagCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "PlaceTagCell"
    
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

    func configure(title: String, cornerRadius: PlaceTagCornerRadius) {
        cellLabel.text = title
        cellLabel.sizeToFit()
        
        switch cornerRadius {
        case .light:
            layer.cornerRadius = PlaceTagCornerRadius.light.rawValue
        case .strong:
            layer.cornerRadius = PlaceTagCornerRadius.strong.rawValue
        }
    }
    
    func setSelectCellStyle() {
        backgroundColor = .tripnnOrange
        cellLabel.textColor = .tripnnWhite
    }
    
    func setUnSelectCellStyle() {
        backgroundColor = .tripnnLightGray
        cellLabel.textColor = .tripnnSemiDark
    }
    
    // MARK: - Setup

    private func setup() {
        backgroundColor = .tripnnLightGray
    
        contentView.addSubview(cellLabel)
        
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            cellLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            cellLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cellLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
}
