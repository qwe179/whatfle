//
//  SplashBuilder.swift
//  What?fle
//
//  Created by 이정환 on 4/10/24.
//

import RIBs

final class SplashComponent: Component<EmptyDependency> {}

// MARK: - Builder

protocol SplashBuildable: Buildable {
    func build() -> LaunchRouting
}

final class SplashBuilder: Builder<EmptyDependency>, SplashBuildable {

    override init(dependency: EmptyDependency) {
        super.init(dependency: dependency)
    }

//    SplashRouting
    func build() -> LaunchRouting {
        let component = SplashComponent(dependency: dependency)
        let viewController = SplashViewController()
        let interactor = SplashInteractor(presenter: viewController)
        return SplashRouter(
            interactor: interactor,
            viewController: viewController,
            component: component
        )
    }
}
