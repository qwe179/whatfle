//
//  RootInteractor.swift
//  What?fle
//
//  Created by 이정환 on 2/23/24.
//

import RIBs
import RxSwift

protocol RootRouting: ViewableRouting {
    func routeToAddList()
    func routeToRegistLocation()
    func detachCurrentView(animated: Bool, completion: (() -> Void)?)
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
}

protocol RootListener: AnyObject {}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {

    weak var router: RootRouting?
    weak var listener: RootListener?

    override init(presenter: RootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    func didSelectAddTab() {
        router?.routeToAddList()
    }
}

extension RootInteractor: AddListener {
    func closeAddRIB() {
        router?.detachCurrentView(animated: false, completion: nil)
    }
}
