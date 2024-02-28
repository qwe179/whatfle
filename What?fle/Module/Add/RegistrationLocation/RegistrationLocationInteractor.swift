//
//  RegistrationLocationInteractor.swift
//  What?fle
//
//  Created by 이정환 on 3/5/24.
//

import RIBs
import RxSwift

protocol RegistrationLocationRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol RegistrationLocationPresentable: Presentable {
    var listener: RegistrationLocationPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RegistrationLocationListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RegistrationLocationInteractor: PresentableInteractor<RegistrationLocationPresentable>, RegistrationLocationInteractable, RegistrationLocationPresentableListener {

    weak var router: RegistrationLocationRouting?
    weak var listener: RegistrationLocationListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: RegistrationLocationPresentable) {
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
