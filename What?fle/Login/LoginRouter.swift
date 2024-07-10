//
//  LoginRouter.swift
//  What?fle
//
//  Created by 23 09 on 7/2/24.
//

import RIBs

protocol LoginInteractable: Interactable, ProfileSettingListener {
    var router: LoginRouting? { get set }
    var listener: LoginListener? { get set }
}

protocol LoginViewControllable: ViewControllable {
}

final class LoginRouter: LaunchRouter<LoginInteractable, LoginViewControllable> {
    private let component: LoginComponent
    private weak var currentChild: ViewableRouting?

    init(
        interactor: LoginInteractable,
        viewController: LoginViewControllable,
        component: LoginComponent
    ) {
        self.component = component
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

}

extension LoginRouter: LoginRouting {
    func routeToProfileSetting() {
        if self.currentChild == nil {
            let router = self.component.profileSetting.build(withListener: self.interactor)
            router.viewControllable.setPresentationStyle(style: .overFullScreen)
            viewController.present(router.viewControllable, animated: true)
            self.attachChild(router)
            self.currentChild = router
        }
    }
}
