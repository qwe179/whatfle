//
//  RegistLocationBuilder.swift
//  What?fle
//
//  Created by 이정환 on 3/5/24.
//

import RIBs

protocol RegistLocationDependency: Dependency {}

final class RegistLocationComponent: Component<RegistLocationDependency> {}

extension RegistLocationComponent: SelectLocationDependency {
    var selectLocationBuilder: SelectLocationBuildable {
        return SelectLocationBuilder(dependency: self)
    }
}

// MARK: - Builder

protocol RegistLocationBuildable: Buildable {
    func build(withListener listener: RegistLocationListener) -> RegistLocationRouting
}

final class RegistLocationBuilder: Builder<RegistLocationDependency>, RegistLocationBuildable {

    deinit {
        print("\(Self.self) is being deinitialized")
    }

    override init(dependency: RegistLocationDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: RegistLocationListener) -> RegistLocationRouting {
        let component = RegistLocationComponent(dependency: dependency)
        let viewController = RegistLocationViewController()
        let interactor = RegistLocationInteractor(presenter: viewController)
        interactor.listener = listener
        viewController.listener = interactor
        return RegistLocationRouter(
            interactor: interactor,
            viewController: viewController,
            component: component
        )
    }
}
