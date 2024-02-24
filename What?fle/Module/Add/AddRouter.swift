//
//  AddRouter.swift
//  What?fle
//
//  Created by 이정환 on 2/24/24.
//

import RIBs

protocol AddInteractable: Interactable {
    var router: AddRouting? { get set }
    var listener: AddListener? { get set }
}

protocol AddViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class AddRouter: ViewableRouter<AddInteractable, AddViewControllable>, AddRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: AddInteractable, viewController: AddViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
