//
//  LoginRouter.swift
//  What?fle
//
//  Created by 23 09 on 7/2/24.
//

import RIBs
import UIKit

protocol LoginInteractable: Interactable {
    var router: LoginRouting? { get set }
    var listener: LoginListener? { get set }
}

protocol LoginViewControllable: ViewControllable {
}

final class LoginRouter: LaunchRouter<LoginInteractable, LoginViewControllable> {
    private weak var listener: LoginListener?
    private weak var component: LoginComponent?
    private weak var loginRouter: LoginRouting?

    init(
        interactor: LoginInteractable,
        viewController: LoginViewControllable,
        component: LoginComponent
    ) {
        self.component = component
        self.listener = interactor.listener
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    deinit {
        print("\(self) is being deinit")
    }

}

extension LoginRouter: LoginRouting {
    func closeLogin() {
        self.viewController.uiviewController.dismiss(animated: true) {
            self.listener?.dismissLogin()
        }
    }
}
