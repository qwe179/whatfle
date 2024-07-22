//
//  HomeRouter.swift
//  What?fle
//
//  Created by 이정환 on 2/24/24.
//

import RIBs

protocol HomeInteractable: Interactable {
    var router: HomeRouting? { get set }
    var listener: HomeListener? { get set }
}

protocol HomeViewControllable: ViewControllable {}

final class HomeRouter: ViewableRouter<HomeInteractable, HomeViewControllable>, HomeRouting {

    override init(interactor: HomeInteractable, viewController: HomeViewControllable) {

    func dismissLogin() {
        if let loginRouter = self.loginRouter {
            self.detachChild(loginRouter)
            self.loginRouter = nil
        }
    }
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
