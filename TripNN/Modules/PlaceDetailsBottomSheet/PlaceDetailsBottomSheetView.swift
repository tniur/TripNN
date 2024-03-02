//
//  PlaceDetailsBottomSheetView.swift
//  TripNN
//
//  Created by Pavel on 23.02.2024.
//

import UIKit

final class PlaceDetailsBottomSheetView: UIView {
    
    // MARK: - View
    
    private let placeInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    private let generalInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private let detailsInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 12
        
        return stack
    }()
    
    private let titleAndTypeInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 7
        
        return stack
    }()
    
    private let ratingInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Вспышка"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        label.textColor = .tripNNDark
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "Пышечная"
        label.font = UIFont(name: "Montserrat-Regular", size: 13)
        label.textColor = .tripNNDark
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Алексеевская, 11"
        label.font = UIFont(name: "Montserrat-Regular", size: 11)
        label.textColor = .tripNNDark
        return label
    }()
    
    private let workingHoursLabel: UILabel = {
        let label = UILabel()
        label.text = "Ежедневно с 10:00 до 21:00"
        label.font = UIFont(name: "Montserrat-Regular", size: 11)
        label.textColor = .tripNNDark
        return label
    }()
    
    private let contactsLabel: UILabel = {
        let label = UILabel()
        label.text = "+7-963-231-96-17"
        label.font = UIFont(name: "Montserrat-Regular", size: 11)
        label.textColor = .tripNNDark
        return label
    }()
    
    private let averageCheckLabel: UILabel = {
        let label = UILabel()
        label.text = "Средний чек 200 ₽"
        label.font = UIFont(name: "Montserrat-Regular", size: 11)
        label.textColor = .tripNNDark
        return label
    }()
    
    private let ratingValueLabel: UILabel = {
        let label = UILabel()
        label.text = "4.5"
        label.font = UIFont(name: "Montserrat-Bold", size: 12)
        label.textColor = .tripNNDark
        
        if let rating = Float(label.text ?? "0") {
            switch rating {
            case 0:
                label.textColor = .tripnnDark
            case ..<3:
                label.textColor = .tripnnRed
            case ..<4:
                label.textColor = .tripnnOrange
            case 4...:
                label.textColor = .tripnnGreen
            default:
                label.textColor = .tripnnDark
            }
        }
        
        return label
    }()
    
    private let numberOfRatingsLabel: UILabel = {
        let label = UILabel()
        label.text = "199 оценок"
        label.font = UIFont(name: "Montserrat-Regular", size: 12)
        label.textColor = .tripNNDark
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
    
    // MARK: - Setup
    
    private func setup() {
        setupView()
        setupConstrains()
    }
    
    private func setupView() {
        self.backgroundColor = .tripnnWhite
        self.addSubview(placeInfoStack)
        setupStack()
    }
    
    private func setupStack() {
        placeInfoStack.addArrangedSubview(generalInfoStack)
        placeInfoStack.addArrangedSubview(detailsInfoStack)
        
        generalInfoStack.addArrangedSubview(titleAndTypeInfoStack)
        generalInfoStack.addArrangedSubview(ratingInfoStack)
        
        titleAndTypeInfoStack.addArrangedSubview(titleLabel)
        titleAndTypeInfoStack.addArrangedSubview(typeLabel)
        
        ratingInfoStack.addArrangedSubview(ratingValueLabel)
        ratingInfoStack.addArrangedSubview(numberOfRatingsLabel)
        
        detailsInfoStack.addArrangedSubview(addressLabel)
        detailsInfoStack.addArrangedSubview(workingHoursLabel)
        detailsInfoStack.addArrangedSubview(contactsLabel)
        detailsInfoStack.addArrangedSubview(averageCheckLabel)
    }
    
    private func setupConstrains() {
        setupPlaceInfoStack()
    }
    
    private func setupPlaceInfoStack() {
        placeInfoStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeInfoStack.topAnchor.constraint(equalTo: topAnchor),
            placeInfoStack.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            placeInfoStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            placeInfoStack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
