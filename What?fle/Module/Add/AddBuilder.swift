//
//  AddBuilder.swift
//  What?fle
//
//  Created by 이정환 on 2/24/24.
//

import RIBs

protocol AddDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class AddComponent: Component<AddDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol AddBuildable: Buildable {
    func build(withListener listener: AddListener) -> AddRouting
}

final class AddBuilder: Builder<AddDependency>, AddBuildable {

    override init(dependency: AddDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: AddListener) -> AddRouting {
        let component = AddComponent(dependency: dependency)
        let viewController = AddViewController()
        let interactor = AddInteractor(presenter: viewController)
        interactor.listener = listener
        return AddRouter(interactor: interactor, viewController: viewController)
    }
}
