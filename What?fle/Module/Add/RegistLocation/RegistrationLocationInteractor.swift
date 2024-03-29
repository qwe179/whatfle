//
//  RegistLocationInteractor.swift
//  What?fle
//
//  Created by 이정환 on 3/5/24.
//

import RIBs
import RxSwift

protocol RegistLocationRouting: ViewableRouting {
    func routeToSelectLocation()
}

protocol RegistLocationPresentable: Presentable {
    var listener: RegistLocationPresentableListener? { get set }
}

protocol RegistLocationListener: AnyObject {
    func closeRegistLocationRIB()
}

final class RegistLocationInteractor: PresentableInteractor<RegistLocationPresentable>, RegistLocationInteractable, RegistLocationPresentableListener {

    weak var router: RegistLocationRouting?
    weak var listener: RegistLocationListener?

    deinit {
        print("\(self) is being deinit")
    }

    override init(presenter: RegistLocationPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    func showSelectLocationRIB() {
        router?.routeToSelectLocation()
    }
}

extension RegistLocationInteractor: RegistLocationListener {
    func closeRegistLocationRIB() {
        listener?.closeRegistLocationRIB()
    }
}
