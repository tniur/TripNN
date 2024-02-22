//
//  cell.swift
//  TripNN
//
//  Created by Pavel on 22.02.2024.
//

import UIKit

extension UISwipeActionsConfiguration {

    public static func makeTitledImage(
        image: UIImage?,
        title: String,
        textColor: UIColor = .white,
        font: UIFont = .systemFont(ofSize: 14),
        size: CGSize = .init(width: 120, height: 100)
    ) -> UIImage? {
        
        /// Create attributed string attachment with image
        let attachment = NSTextAttachment()
        attachment.image = image
        let imageString = NSAttributedString(attachment: attachment)
        
        /// Create attributed string with title
        let text = NSAttributedString(
            string: "\n\(title)",
            attributes: [
                .foregroundColor: textColor,
                .font: font
            ]
        )
        
        /// Merge two attributed strings
        let mergedText = NSMutableAttributedString()
        mergedText.append(imageString)
        mergedText.append(text)
        
        /// Create label and append that merged attributed string
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 3
        label.attributedText = mergedText
        label.textColor = .tripnnRed
        label.font =  UIFont(name: "Montserrat-Medium", size: 10)
        
        /// Create image from that label
        let renderer = UIGraphicsImageRenderer(bounds: label.bounds)
        let image = renderer.image { rendererContext in
            label.layer.render(in: rendererContext.cgContext)
        }
        
        /// Convert it to UIImage and return
        if let cgImage = image.cgImage {
            return UIImage(cgImage: cgImage, scale: UIScreen.main.scale, orientation: .up)
        }
        
        return nil
    }
}
