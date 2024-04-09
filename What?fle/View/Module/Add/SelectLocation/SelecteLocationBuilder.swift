//
//  SelectLocationBuilder.swift
//  What?fle
//
//  Created by 이정환 on 2/25/24.
//

import RIBs

protocol SelectLocationDependency: Dependency {
    var networkService: NetworkServiceDelegate { get }
}

final class SelectLocationComponent: Component<SelectLocationDependency> {
    var networkService: NetworkServiceDelegate {
        return dependency.networkService
    }
}

// MARK: - Builder

protocol SelectLocationBuildable: Buildable {
    func build(withListener listener: SelectLocationListener) -> SelectLocationRouting
}

final class SelectLocationBuilder: Builder<SelectLocationDependency>, SelectLocationBuildable {

    deinit {
        print("\(Self.self) is being deinitialized")
    }

    override init(dependency: SelectLocationDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SelectLocationListener) -> SelectLocationRouting {
        let component = SelectLocationComponent(dependency: dependency)
        let viewController = SelectLocationViewController()
        let interactor = SelectLocationInteractor(presenter: viewController, networkService: component.networkService)
        interactor.listener = listener
        viewController.listener = interactor
        return SelectLocationRouter(
            interactor: interactor,
            viewController: viewController,
            component: component
        )
    }
}
