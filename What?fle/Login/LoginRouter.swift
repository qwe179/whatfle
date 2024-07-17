//
//  LoginRouter.swift
//  What?fle
//
//  Created by 23 09 on 7/2/24.
//

import RIBs
import UIKit

protocol LoginInteractable: Interactable, ProfileSettingListener {
    var router: LoginRouting? { get set }
    var listener: LoginListener? { get set }
}

protocol LoginViewControllable: ViewControllable {
}

final class LoginRouter: LaunchRouter<LoginInteractable, LoginViewControllable> {
    private let component: LoginComponent
    private weak var loginRouter: LoginRouting?
    private weak var profileSettingRouter: ProfileSettingRouting?

    init(
        interactor: LoginInteractable,
        viewController: LoginViewControllable,
        component: LoginComponent
    ) {
        self.component = component
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    deinit {
        print("\(self) is being deinit")
    }

}

extension LoginRouter: LoginRouting {
    func routeToProfileSetting() {
        if self.profileSettingRouter == nil {
            self.viewController.uiviewController.dismiss(animated: true) {
                let router = self.component.profileSettingBuilder.build(withListener: self.interactor)
                router.viewControllable.uiviewController.modalPresentationStyle = .overFullScreen
                self.viewControllable.uiviewController.present(router.viewControllable.uiviewController, animated: true)
                self.attachChild(router)
                self.profileSettingRouter = router
            }
        }
    }
}
