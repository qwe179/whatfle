//
//  AddInteractor.swift
//  What?fle
//
//  Created by 이정환 on 2/24/24.
//

import RIBs
import RxSwift

protocol AddRouting: ViewableRouting {}

protocol AddPresentable: Presentable {
    var listener: AddPresentableListener? { get set }
}

protocol AddListener: AnyObject {
    func closeAddRIB()
    func showRegistrationLocationRIB()
}

final class AddInteractor: PresentableInteractor<AddPresentable>, AddInteractable, AddPresentableListener {
    weak var router: AddRouting?
    weak var listener: AddListener?

    deinit {
        print("\(self) is being deinit")
    }

    override init(presenter: AddPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    func showRegistrationLocation() {
        listener?.showRegistrationLocationRIB()
    }
    
    func closeView() {
        listener?.closeAddRIB()
    }
}
