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
        additionalAttributes: [(text: String, attribute: [NSAttributedString.Key: Any])]? = nil
    ) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineHeight - (font.lineHeight - font.pointSize)
        let baseAttributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: font,
            .foregroundColor: textColor
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
