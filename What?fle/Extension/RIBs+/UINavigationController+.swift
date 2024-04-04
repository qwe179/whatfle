//
//  ViewControllable+.swift
//  What?fle
//
//  Created by 이정환 on 2/27/24.
//

import RIBs

import UIKit

extension UINavigationController: ViewControllable {
    public var uiviewController: UIViewController { return self }

    public convenience init(root: ViewControllable) {
        self.init(rootViewController: root.uiviewController)
    }
}
