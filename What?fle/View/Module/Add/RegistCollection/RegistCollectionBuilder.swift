//
//  RegistCollectionBuilder.swift
//  What?fle
//
//  Created by 이정환 on 4/17/24.
//

import RIBs

protocol RegistCollectionDependency: Dependency {
    var networkService: NetworkServiceDelegate { get }
}

final class RegistCollectionComponent: Component<RegistCollectionDependency> {
    var networkService: NetworkServiceDelegate {
        return dependency.networkService
    }
}

// MARK: - Builder

protocol RegistCollectionBuildable: Buildable {
    func build(withListener listener: RegistCollectionListener) -> RegistCollectionRouting
}

final class RegistCollectionBuilder: Builder<RegistCollectionDependency>, RegistCollectionBuildable {

    deinit {
        print("\(self) is being deinit")
    }
    
    override init(dependency: RegistCollectionDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: RegistCollectionListener) -> RegistCollectionRouting {
        let component = RegistCollectionComponent(dependency: dependency)
        let viewController = RegistCollectionViewController()
        let interactor = RegistCollectionInteractor(presenter: viewController, networkService: component.networkService)
        interactor.listener = listener
        return RegistCollectionRouter(
            interactor: interactor,
            viewController: viewController,
            component: component
        )
    }
}
