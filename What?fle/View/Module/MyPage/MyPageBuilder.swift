//
//  MyPageBuilder.swift
//  What?fle
//
//  Created by 23 09 on 7/2/24.
//

import RIBs
import UIKit

protocol MyPageDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class MyPageComponent: Component<MyPageDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol MyPageBuildable: Buildable {
    func build(withListener listener: MyPageListener) -> MyPageRouting
}

final class MyPageBuilder: Builder<MyPageDependency>, MyPageBuildable {

    override init(dependency: MyPageDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: MyPageListener) -> MyPageRouting {
        let component = MyPageComponent(dependency: dependency)
        let viewController = MyPageViewController()
        let navigationController = UINavigationController(root: viewController)
        navigationController.modalPresentationStyle = .overFullScreen
        let interactor = MyPageInteractor(presenter: viewController)
        interactor.listener = listener
        return MyPageRouter(
            interactor: interactor,
            viewController: viewController,
            navigationController: navigationController,
            component: component
        )
    }
}
