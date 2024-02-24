//
//  PlaceDetailsBottomSheetView.swift
//  TripNN
//
//  Created by Pavel on 23.02.2024.
//

import UIKit

final class PlaceDetailsBottomSheetView: UIView {
    
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
    }
    
    private func setupConstrains() {

    }

}
