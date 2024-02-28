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

protocol AddViewControllable: ViewControllable {}

final class AddRouter: ViewableRouter<AddInteractable, AddViewControllable>, AddRouting {

    private let component: AddComponent

    deinit {
        print("\(Self.self) is being deinitialized")
    }

    init(
        interactor: AddInteractable,
        viewController: AddViewControllable,
        component: AddComponent
    ) {
        self.component = component
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
