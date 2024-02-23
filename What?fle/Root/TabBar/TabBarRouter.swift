//
//  TabBarRouter.swift
//  What?fle
//
//  Created by 이정환 on 2/23/24.
//

import RIBs

protocol TabBarInteractable: Interactable {
    var router: TabBarRouting? { get set }
    var listener: TabBarListener? { get set }
}

protocol TabBarViewControllable: ViewControllable {
    func setViewControllers(_ viewControllers: [ViewControllable])
}

final class TabBarRouter: ViewableRouter<TabBarInteractable, TabBarViewControllable>, TabBarRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: TabBarInteractable, viewController: TabBarViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
