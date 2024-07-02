//
//  MyPageRouter.swift
//  What?fle
//
//  Created by 23 09 on 7/2/24.
//

import RIBs

protocol MyPageInteractable: Interactable {
    var router: MyPageRouting? { get set }
    var listener: MyPageListener? { get set }
}

protocol MyPageViewControllable: ViewControllable {}

final class MyPageRouter: ViewableRouter<MyPageInteractable, MyPageViewControllable>, MyPageRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: MyPageInteractable, viewController: MyPageViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
