//
//  AddCollectionInteractor.swift
//  What?fle
//
//  Created by 이정환 on 4/6/24.
//

import RIBs
import RxSwift

protocol AddCollectionRouting: ViewableRouting {}

protocol AddCollectionPresentable: Presentable {
    var listener: AddCollectionPresentableListener? { get set }
}

protocol AddCollectionListener: AnyObject {
    func closeAddCollection()
    func showRegistLocation()
}

final class AddCollectionInteractor: PresentableInteractor<AddCollectionPresentable>,
                                     AddCollectionInteractable,
                                     AddCollectionPresentableListener {
    weak var router: AddCollectionRouting?
    weak var listener: AddCollectionListener?

    override init(presenter: AddCollectionPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
}

extension AddCollectionInteractor: AddCollectionListener {
    func closeAddCollection() {
        listener?.closeAddCollection()
    }

    func showRegistLocation() {
        listener?.closeAddCollection()
        listener?.showRegistLocation()
    }
}
