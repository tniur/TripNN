//
//  PlaceDetailsCollectionViewCell.swift
//  TripNN
//
//  Created by Pavel on 04.03.2024.
//

import UIKit

final class PlaceDetailsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - View
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 9
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    func configure(image: UIImage) {
        imageView.image = image
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupView()
        setupConstrains()
    }
    
    private func setupView() {
        contentView.addSubview(imageView)
    }
    
    private func setupConstrains() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
