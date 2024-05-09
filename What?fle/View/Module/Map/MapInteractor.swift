//
//  MapInteractor.swift
//  What?fle
//
//  Created by 이정환 on 2/24/24.
//

import RIBs
import RxSwift

protocol MapRouting: ViewableRouting {}

protocol MapPresentable: Presentable {
    var listener: MapPresentableListener? { get set }
}

protocol MapListener: AnyObject {}

final class MapInteractor: PresentableInteractor<MapPresentable>, MapInteractable, MapPresentableListener {

    weak var router: MapRouting?
    weak var listener: MapListener?

    override init(presenter: MapPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
}
