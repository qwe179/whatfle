//
//  String+.swift
//  What?fle
//
//  Created by 이정환 on 3/29/24.
//

import UIKit

extension NSAttributedString {
    static func makeAttributedString(
        text: String,
        font: UIFont,
        textColor: UIColor,
        lineHeight: CGFloat,
        lineSpacing: CGFloat = 0.0,
        additionalAttributes: [(text: String, attribute: [NSAttributedString.Key: Any])]? = nil
    ) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.lineSpacing = lineSpacing
        let baseAttributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: font,
            .foregroundColor: textColor,
            .baselineOffset: (lineHeight - font.lineHeight) / 2
        ]

        if let additionalAttributes {
            let attributedString = NSMutableAttributedString(string: text, attributes: baseAttributes)
            for additionalAttribute in additionalAttributes {
                let range = (text as NSString).range(of: additionalAttribute.text)
                attributedString.addAttributes(additionalAttribute.attribute, range: range)
            }
            return attributedString
        }
        return NSAttributedString(string: text, attributes: baseAttributes)
    }
}
