//
//  FindPlacesMenuView.swift
//  TripNN
//
//  Created by Pavel on 11.03.2024.
//

import UIKit

final class FindPlacesMenuView: UIView {
    
    // MARK: - Properties
    
    let segmentedControlItems = [String(localized: "culture"), String(localized: "leisure"), String(localized: "food")]
    
    // MARK: - Closures
    
    var onNextStepButtonAction: (() -> Void)?

    // MARK: - View
    
    private let nextStepButton = BigButton(withTitle: String(localized: "next_step"))

    lazy var placesSegmentedControl = SegmentedControl(items: segmentedControlItems)
    
    
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
        addAction()
    }
    
    private func setupView() {
        self.addSubview(nextStepButton)
        self.addSubview(placesSegmentedControl)
    }
    
    private func setupConstraints() {
        setupNextStepButtonConstraints()
        setupPlacesSegmentedControlConstraints()
    }
    
    private func addAction() {
        nextStepButton.addTarget(self, action: #selector(nextStepButtonAction), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func nextStepButtonAction() {
        onNextStepButtonAction?()
    }
    
    // MARK: - Constraints
    
    private func setupNextStepButtonConstraints() {
        nextStepButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextStepButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextStepButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40)
        ])
    }
    
    private func setupPlacesSegmentedControlConstraints() {
        placesSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placesSegmentedControl.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            placesSegmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            placesSegmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
}
