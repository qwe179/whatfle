//
//  AddInteractor.swift
//  What?fle
//
//  Created by 이정환 on 2/24/24.
//

import RIBs
import RxSwift
import UIKit

protocol AddRouting: ViewableRouting {
    var navigationController: UINavigationController { get }
    func routeToRegistLocation()
    func routeToAddCollection()
    func routeToRegistCollection()
    func closeCurrentRIB()
}

protocol AddPresentable: Presentable {
    var listener: AddPresentableListener? { get set }
}

protocol AddListener: AnyObject {
    func closeAddRIB()
}

final class AddInteractor: PresentableInteractor<AddPresentable>, AddInteractable {
    weak var router: AddRouting?
    weak var listener: AddListener?

    deinit {
        print("\(self) is being deinit")
    }

    override init(presenter: AddPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    func closeView() {
        listener?.closeAddRIB()
    }
}

extension AddInteractor: AddPresentableListener {
    func showRegistLocation() {
        router?.routeToRegistLocation()
    }

    func showAddCollection() {
        router?.routeToAddCollection()
    }

    func closeRegistLocation() {
        router?.closeCurrentRIB()
    }

    func closeAddCollection() {
        router?.closeCurrentRIB()
    }
    
    func showRegistCollection() {
        router?.routeToRegistCollection()
    }
}
