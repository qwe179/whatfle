//
//  RootViewController.swift
//  What?fle
//
//  Created by 이정환 on 2/23/24.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: AnyObject {
    func didSelectAddTab()
}

final class RootViewController: UITabBarController, RootPresentable {

    weak var listener: RootPresentableListener?
    private var animationInProgress = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.setTabBar()
        self.setUI()
    }
}

extension RootViewController {
    private func setTabBar() {
        self.tabBar.tintColor = .GrayScale.g400
    }

    private func setUI() {
        view.backgroundColor = .white
    }
}

extension RootViewController: RootViewControllable {
    func setTabBarViewController(_ viewControllers: [UINavigationController], animated: Bool) {
        let viewControllers = viewControllers.map { $0 }
        self.setViewControllers(viewControllers, animated: animated)
    }

    func getAddNavigationController() -> UINavigationController? {
        return self.viewControllers?[self.selectedIndex] as? UINavigationController
    }
}

extension RootViewController: UITabBarControllerDelegate {
    func tabBarController(
        _ tabBarController: UITabBarController,
        shouldSelect viewController: UIViewController
    ) -> Bool {
        if let index = self.viewControllers?.firstIndex(of: viewController), index == 1 {
            listener?.didSelectAddTab()
            return false
        }
        return true
    }
}
