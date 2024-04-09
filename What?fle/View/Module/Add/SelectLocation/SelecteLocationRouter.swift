//
//  SelectLocationRouter.swift
//  What?fle
//
//  Created by 이정환 on 2/25/24.
//

import RIBs

protocol SelectLocationInteractable: Interactable {
    var router: SelectLocationRouting? { get set }
    var listener: SelectLocationListener? { get set }
}

protocol SelectLocationViewControllable: ViewControllable {}

final class SelectLocationRouter: ViewableRouter<SelectLocationInteractable, SelectLocationViewControllable> {
    private let component: SelectLocationComponent
    private weak var currentChild: ViewableRouting?

    deinit {
        print("\(Self.self) is being deinitialized")
    }

    init(
        interactor: SelectLocationInteractable,
        viewController: SelectLocationViewControllable,
        component: SelectLocationComponent
    ) {
        self.component = component
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension SelectLocationRouter: SelectLocationRouting {}
