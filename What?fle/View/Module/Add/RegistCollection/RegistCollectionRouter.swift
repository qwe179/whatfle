//
//  RegistCollectionRouter.swift
//  What?fle
//
//  Created by 이정환 on 4/17/24.
//

import RIBs

protocol RegistCollectionInteractable: Interactable, AddCollectionListener {
    var router: RegistCollectionRouting? { get set }
    var listener: RegistCollectionListener? { get set }
}

protocol RegistCollectionViewControllable: ViewControllable {}

final class RegistCollectionRouter: ViewableRouter<RegistCollectionInteractable, RegistCollectionViewControllable> {
    private let component: RegistCollectionComponent
    private weak var currentChild: ViewableRouting?

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

extension RegistCollectionRouter: RegistCollectionRouting {
    func routeToRegistCollection(data: EditSelectedCollectionData) {
        let router = self.component.addCollectionBuilder.build(withListener: self.interactor, withData: data)
        router.viewControllable.uiviewController.modalPresentationStyle = .fullScreen
        self.viewControllable.uiviewController.present(router.viewControllable.uiviewController, animated: true, completion: nil)
        self.attachChild(router)
        self.currentChild = router
    }

    func closeCurrentRIB() {
        if let currentChild {
            self.detachChild(currentChild)
            self.currentChild = nil
        }
    }
}
