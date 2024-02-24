//
//  RootViewController.swift
//  What?fle
//
//  Created by 이정환 on 2/23/24.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: AnyObject {}

final class RootViewController: UITabBarController, RootPresentable {

    weak var listener: RootPresentableListener?

    override func viewDidLoad() {
        self.setTabBar()
        self.setUI()
    }

    private func setTabBar() {
        self.tabBar.tintColor = .GrayScale.g400

    }

    private func setUI() {
        view.backgroundColor = .white
    }
}


extension RootViewController: RootViewControllable {
    
    func setTabBarViewController(_ viewControllers: [ViewControllable], animated: Bool) {
        let viewControllers = viewControllers.map { $0.uiviewController }
        self.setViewControllers(viewControllers, animated: animated)
    }

//    func present(viewController: ViewControllable) {
//        self.present(viewController.uiviewController, animated: true)
//        print("함수 present 실행")
//    }
}
