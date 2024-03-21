//
//  Title.swift
//  TripNN
//
//  Created by Pavel on 14.03.2024.
//

import UIKit

enum FontStyle {
    case light
    case regular
    case medium
    case semiBold
    case bold
    case black
}

class Title: UILabel {

    // MARK: - Init
    
    init(text: String? = "text", font: FontStyle, size: CGFloat, color: UIColor? = .tripnnDark) {
        super.init(frame: .zero)
        
        setup(text: text, font: font, size: size, color: color)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setup
    
    private func setup(text: String?, font: FontStyle, size: CGFloat, color: UIColor?) {
        self.text = text
        textColor = color
        
        var fontName = "Montserrat-"
        
        switch font {
            case .light:
                fontName += "Light"
            case .regular:
                fontName += "Regular"
            case .medium:
                fontName += "Medium"
            case .semiBold:
                fontName += "SemiBold"
            case .bold:
                fontName += "Bold"
            case .black:
                fontName += "Black"
        }
        
        self.font =  UIFont(name: fontName, size: size)
    }
}
