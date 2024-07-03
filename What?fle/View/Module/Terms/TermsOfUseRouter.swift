//
//  TermsOfUseRouter.swift
//  What?fle
//
//  Created by 23 09 on 7/3/24.
//

import RIBs

protocol TermsOfUseInteractable: Interactable {
    var router: TermsOfUseRouting? { get set }
    var listener: TermsOfUseListener? { get set }
}

protocol TermsOfUseViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class TermsOfUseRouter: ViewableRouter<TermsOfUseInteractable, TermsOfUseViewControllable>, TermsOfUseRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: TermsOfUseInteractable, viewController: TermsOfUseViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
