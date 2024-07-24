//
//  HomeRouter.swift
//  What?fle
//
//  Created by 이정환 on 2/24/24.
//

import RIBs
import UIKit

protocol HomeInteractable: Interactable, LoginListener {
    var router: HomeRouting? { get set }
    var listener: HomeListener? { get set }
}

protocol HomeViewControllable: ViewControllable {}

final class HomeRouter: ViewableRouter<HomeInteractable, HomeViewControllable>, HomeRouting, LoginListener {
    private let component: HomeComponent
    private weak var homeRouter: HomeRouting?
    private weak var loginRouter: LoginRouting?

    func routeToLogin() {
        let router = self.component.loginBuilder.build(withListener: self.interactor)
        let nextVc = router.viewControllable.uiviewController
        nextVc.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.viewControllable.uiviewController.present(nextVc, animated: true)
        self.attachChild(router)
        self.loginRouter = router
    }

    func dismissLogin() {
        if let loginRouter = self.loginRouter {
            self.detachChild(loginRouter)
            self.loginRouter = nil
        }
    }

    init(
        interactor: HomeInteractable,
        viewController: HomeViewControllable,
        component: HomeComponent
    ) {
        self.component = component
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
