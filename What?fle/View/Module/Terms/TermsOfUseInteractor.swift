//
//  TermsOfUseInteractor.swift
//  What?fle
//
//  Created by 23 09 on 7/3/24.
//

import RIBs
import RxSwift

protocol TermsOfUseRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol TermsOfUsePresentable: Presentable {
    var listener: TermsOfUsePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol TermsOfUseListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class TermsOfUseInteractor: PresentableInteractor<TermsOfUsePresentable>, TermsOfUseInteractable, TermsOfUsePresentableListener {

    weak var router: TermsOfUseRouting?
    weak var listener: TermsOfUseListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: TermsOfUsePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
