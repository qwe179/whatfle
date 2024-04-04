//
//  UIApplication+.swift
//  What?fle
//
//  Created by 이정환 on 3/3/24.
//

import UIKit

extension UIApplication {
    var keyWindow: UIWindow? {
        return UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }

    var width: CGFloat {
        return UIApplication
            .shared
            .keyWindow?
            .screen
            .bounds
            .width ?? 0
    }

    var height: CGFloat {
        return UIApplication
            .shared
            .keyWindow?
            .screen
            .bounds
            .height ?? 0
    }

    var statusBarHeight: CGFloat {
        return UIApplication
            .shared
            .keyWindow?
            .windowScene?
            .statusBarManager?
            .statusBarFrame
            .height ?? 0
    }
}
