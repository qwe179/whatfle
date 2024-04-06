//
//  ViewControllable.swift
//  What?fle
//
//  Created by 이정환 on 3/8/24.
//

import RIBs
import UIKit

extension ViewControllable {
    func setPresentationStyle(style: UIModalPresentationStyle) {
        self.uiviewController.modalPresentationStyle = style
    }

    func present(_ viewController: ViewControllable, animated: Bool) {
        self.uiviewController.present(viewController.uiviewController, animated: animated)
    }

    func present(_ navigationController: UINavigationController, animated: Bool) {
        self.uiviewController.present(navigationController, animated: animated)
    }

/*
    func push(_ navigationController: UINavigationController, animated: Bool) {
//        if let navigationController = self.uiviewController.navigationController {
//            navigationController.pushViewController(viewController.uiviewController, animated: animated)
//        } else {
        navigationController.pushViewController(navigationController.uiviewController, animated: animated)
//            UINavigationController().pushViewController(viewController.uiviewController, animated: animated)
//        }
    }

    func pop(animated: Bool) {
        guard let navigationController = self.uiviewController.navigationController else { return }
        navigationController.popViewController(animated: animated)
    }
 */
}
