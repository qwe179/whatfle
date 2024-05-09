//
//  MapBuilder.swift
//  What?fle
//
//  Created by 이정환 on 2/24/24.
//

import RIBs

protocol MapDependency: Dependency {}

final class MapComponent: Component<MapDependency> {}

// MARK: - Builder

protocol MapBuildable: Buildable {
    func build(withListener listener: MapListener) -> MapRouting
}

final class MapBuilder: Builder<MapDependency>, MapBuildable {

    override init(dependency: MapDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: MapListener) -> MapRouting {
        let component = MapComponent(dependency: dependency)
        let viewController = MapViewController()
        let interactor = MapInteractor(presenter: viewController)
        interactor.listener = listener
        return MapRouter(interactor: interactor, viewController: viewController)
    }
}
