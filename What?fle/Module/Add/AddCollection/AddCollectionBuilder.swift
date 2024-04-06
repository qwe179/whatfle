//
//  AddCollectionBuilder.swift
//  What?fle
//
//  Created by 이정환 on 4/6/24.
//

import RIBs

protocol AddCollectionDependency: Dependency {}

final class AddCollectionComponent: Component<AddCollectionDependency> {}

extension AddCollectionComponent: AddCollectionDependency {
    var selectLocationBuilder: AddCollectionBuildable {
        return AddCollectionBuilder(dependency: self)
    }
}

// MARK: - Builder

protocol AddCollectionBuildable: Buildable {
    func build(withListener listener: AddCollectionListener, screenType: AddCollectionType) -> AddCollectionRouting
}

final class AddCollectionBuilder: Builder<AddCollectionDependency>, AddCollectionBuildable {

    override init(dependency: AddCollectionDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: AddCollectionListener, screenType: AddCollectionType) -> AddCollectionRouting {
        let component = AddCollectionComponent(dependency: dependency)
        let viewController = AddCollectionViewController(screenType: screenType)
        let interactor = AddCollectionInteractor(presenter: viewController)
        interactor.listener = listener
        return AddCollectionRouter(
            interactor: interactor,
            viewController: viewController,
            component: component
        )
    }
}
