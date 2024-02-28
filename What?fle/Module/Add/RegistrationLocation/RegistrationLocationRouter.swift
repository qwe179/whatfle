//
//  RegistrationLocationRouter.swift
//  What?fle
//
//  Created by 이정환 on 3/5/24.
//

import RIBs

protocol RegistrationLocationInteractable: Interactable {
    var router: RegistrationLocationRouting? { get set }
    var listener: RegistrationLocationListener? { get set }
}

protocol RegistrationLocationViewControllable: ViewControllable {
    func push(viewController: ViewControllable)
    func pushWithOutTabBar(with viewController: ViewControllable, animated: Bool)
}

final class RegistrationLocationRouter: ViewableRouter<RegistrationLocationInteractable, RegistrationLocationViewControllable>, RegistrationLocationRouting {

    override init(interactor: RegistrationLocationInteractable, viewController: RegistrationLocationViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
