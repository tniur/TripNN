//
//  NewRouteSettingsView.swift
//  TripNN
//
//  Created by Pavel on 19.02.2024.
//

import UIKit

class NewRouteSettingsView: UIView {
    
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

    }
    
    private func setupConstraints() {

    }
}
