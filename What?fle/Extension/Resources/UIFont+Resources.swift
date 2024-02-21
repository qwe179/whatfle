//
//  UIFont+.swift
//  What?fle
//
//  Created by 이정환 on 2/22/24.
//

import UIKit

// MARK: - Pretendard Font

extension UIFont {
    enum FontWeight: String {
        case heavy = "Heavy"
        case extraBold = "ExtraBold"
        case bold = "Bold"
        case semiBold = "SemiBold"
        case medium = "Medium"
        case regular = "Regular"
        case light = "Light"
        case extraLight = "ExtraLight"
        case thin = "Thin"
    }

    static func suit(size: CGFloat, weight: FontWeight) -> UIFont {
        return UIFont(name: "SUIT-\(weight.rawValue)", size: size)!
    }
}

// MARK: - Project Typo

extension UIFont {
    static var title32HV: UIFont {
        return .suit(size: 32, weight: .heavy)
    }

    static var title24XBD: UIFont {
        return .suit(size: 24, weight: .extraBold)
    }

    static var title20XBD: UIFont {
        return .suit(size: 20, weight: .extraBold)
    }

    static var title16XBD: UIFont {
        return .suit(size: 16, weight: .extraBold)
    }

    static var title16MD: UIFont {
        return .suit(size: 16, weight: .medium)
    }

    static var title15XBD: UIFont {
        return .suit(size: 15, weight: .extraBold)
    }

    static var title15SB: UIFont {
        return .suit(size: 15, weight: .semiBold)
    }

    static var title15RG: UIFont {
        return .suit(size: 15, weight: .regular)
    }

    static var body14XBD: UIFont {
        return .suit(size: 14, weight: .extraBold)
    }

    static var body14SB: UIFont {
        return .suit(size: 14, weight: .semiBold)
    }

    static var body14MD: UIFont {
        return .suit(size: 14, weight: .medium)
    }

    static var body14RG: UIFont {
        return .suit(size: 14, weight: .regular)
    }

    static var body13BD: UIFont {
        return .suit(size: 13, weight: .bold)
    }

    static var body13MD: UIFont {
        return .suit(size: 13, weight: .medium)
    }

    static var body12BD: UIFont {
        return .suit(size: 12, weight: .bold)
    }

    static var body12RG: UIFont {
        return .suit(size: 12, weight: .regular)
    }
}
