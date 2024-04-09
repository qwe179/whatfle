//
//  AddCollectionRouter.swift
//  What?fle
//
//  Created by 이정환 on 4/6/24.
//

import RIBs

protocol AddCollectionInteractable: Interactable {
    var router: AddCollectionRouting? { get set }
    var listener: AddCollectionListener? { get set }
}

protocol AddCollectionViewControllable: ViewControllable {}

final class AddCollectionRouter: ViewableRouter<AddCollectionInteractable, AddCollectionViewControllable> {
    private let component: AddCollectionComponent
    private weak var currentChild: ViewableRouting?

    init(
        interactor: AddCollectionInteractable,
        viewController: AddCollectionViewControllable,
        component: AddCollectionComponent
    ) {
        self.component = component
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension AddCollectionRouter: AddCollectionRouting {}
