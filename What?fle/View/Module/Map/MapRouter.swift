//
//  MapRouter.swift
//  What?fle
//
//  Created by 이정환 on 2/24/24.
//

import RIBs

protocol MapInteractable: Interactable {
    var router: MapRouting? { get set }
    var listener: MapListener? { get set }
}

protocol MapViewControllable: ViewControllable {}

final class MapRouter: ViewableRouter<MapInteractable, MapViewControllable>, MapRouting {

    override init(interactor: MapInteractable, viewController: MapViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
