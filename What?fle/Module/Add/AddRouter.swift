//
//  AddRouter.swift
//  What?fle
//
//  Created by 이정환 on 2/24/24.
//

import RIBs
import UIKit

protocol AddInteractable: Interactable, RegistLocationListener {
    var router: AddRouting? { get set }
    var listener: AddListener? { get set }
}

protocol AddViewControllable: ViewControllable {}

final class AddRouter: ViewableRouter<AddInteractable, AddViewControllable> {
    private let component: AddComponent
    let navigationController: UINavigationController
    private weak var currentChild: ViewableRouting?

    deinit {
        print("\(Self.self) is being deinitialized")
    }

    init(
        interactor: AddInteractable,
        viewController: AddViewControllable,
        navigationController: UINavigationController,
        component: AddComponent
    ) {
        self.component = component
        self.navigationController = navigationController
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension AddRouter: AddRouting {
    func routeToRegistLocation() {
        if self.currentChild == nil {
            let router = self.component.registLocatiionBuilder.build(withListener: self.interactor)
            self.navigationController.setNavigationBarHidden(true, animated: false)
            self.navigationController.pushViewController(router.viewControllable.uiviewController, animated: true)
            self.attachChild(router)
            self.currentChild = router
        }
    }

    func closeRegistLocation() {
        if let currentChild {
            detachChild(currentChild)
            self.currentChild = nil
        }
    }
}
