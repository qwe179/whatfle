//
//  RegistrationLocationBuilder.swift
//  What?fle
//
//  Created by 이정환 on 3/5/24.
//

import RIBs

protocol RegistrationLocationDependency: Dependency {}

final class RegistrationLocationComponent: Component<RegistrationLocationDependency> {}

// MARK: - Builder

protocol RegistrationLocationBuildable: Buildable {
    func build(withListener listener: RegistrationLocationListener) -> RegistrationLocationRouting
}

final class RegistrationLocationBuilder: Builder<RegistrationLocationDependency>, RegistrationLocationBuildable {

    override init(dependency: RegistrationLocationDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: RegistrationLocationListener) -> RegistrationLocationRouting {
        let component = RegistrationLocationComponent(dependency: dependency)
        let viewController = RegistrationLocationViewController()
        let interactor = RegistrationLocationInteractor(presenter: viewController)
        interactor.listener = listener
        return RegistrationLocationRouter(interactor: interactor, viewController: viewController)
    }
}
