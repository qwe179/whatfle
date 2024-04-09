//
//  AddRouter.swift
//  What?fle
//
//  Created by 이정환 on 2/24/24.
//

import RIBs
import UIKit

protocol AddInteractable: Interactable, RegistLocationListener, AddCollectionListener {
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

    func routeToAddCollection() {
        if self.currentChild == nil {
            // TODO: - 서버 추가되면 스크린타입 분기처리해야함.
            let router = self.component.addCollectionBuilder.build(withListener: self.interactor)
            self.navigationController.setNavigationBarHidden(true, animated: false)
            self.navigationController.pushViewController(router.viewControllable.uiviewController, animated: true)
            self.attachChild(router)
            self.currentChild = router
        }
    }

    func closeCurrentRIB() {
        if let currentChild {
            self.detachChild(currentChild)
            self.currentChild = nil
        }
    }
}
