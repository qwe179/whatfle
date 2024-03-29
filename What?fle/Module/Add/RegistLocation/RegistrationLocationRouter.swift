//
//  RegistLocationRouter.swift
//  What?fle
//
//  Created by 이정환 on 3/5/24.
//

import RIBs

protocol RegistLocationInteractable: Interactable, SelectLocationListener {
    var router: RegistLocationRouting? { get set }
    var listener: RegistLocationListener? { get set }
}

protocol RegistLocationViewControllable: ViewControllable {}

final class RegistLocationRouter: ViewableRouter<RegistLocationInteractable, RegistLocationViewControllable> {
    private let component: RegistLocationComponent
    private weak var currentChild: ViewableRouting?

    init(
        interactor: RegistLocationInteractable,
        viewController: RegistLocationViewControllable,
        component: RegistLocationComponent
    ) {
        self.component = component
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension RegistLocationRouter: RegistLocationRouting {
    func routeToSelectLocation() {
        if self.currentChild == nil {
            let router = self.component.selectLocationBuilder.build(withListener: self.interactor)
            self.viewController.present(router.viewControllable, animated: true)
            self.attachChild(router)
            self.currentChild = router
        }
    }
}
