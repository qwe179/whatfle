//
//  RegistCollectionRouter.swift
//  What?fle
//
//  Created by 이정환 on 4/17/24.
//

import RIBs

protocol RegistCollectionInteractable: Interactable {
    var router: RegistCollectionRouting? { get set }
    var listener: RegistCollectionListener? { get set }
}

protocol RegistCollectionViewControllable: ViewControllable {}

final class RegistCollectionRouter: ViewableRouter<RegistCollectionInteractable, RegistCollectionViewControllable> {
    private let component: RegistCollectionComponent

    deinit {
        print("\(self) is being deinit")
    }
    
    init(
        interactor: RegistCollectionInteractable,
        viewController: RegistCollectionViewControllable,
        component: RegistCollectionComponent
    ) {
        self.component = component
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension RegistCollectionRouter: RegistCollectionRouting {}
