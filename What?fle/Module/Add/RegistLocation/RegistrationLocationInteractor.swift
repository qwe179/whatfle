//
//  RegistLocationInteractor.swift
//  What?fle
//
//  Created by 이정환 on 3/5/24.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit

protocol RegistLocationRouting: ViewableRouting {
    func routeToSelectLocation()
    func closeSelectLocation()
}

protocol RegistLocationPresentable: Presentable {
    var listener: RegistLocationPresentableListener? { get set }
    func updateView(with data: KakaoSearchDocumentsModel)
}

protocol RegistLocationListener: AnyObject {
    func closeRegistLocation()
}

final class RegistLocationInteractor: PresentableInteractor<RegistLocationPresentable>,
                                      RegistLocationInteractable,
                                      RegistLocationPresentableListener {

    weak var router: RegistLocationRouting?
    weak var listener: RegistLocationListener?
    var imageArray = BehaviorRelay<[UIImage]>(value: [])
    let isSelectLocation = BehaviorRelay<Bool>(value: false)

    deinit {
        print("\(self) is being deinit")
    }

    override init(presenter: RegistLocationPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    func showSelectLocation() {
        router?.routeToSelectLocation()
    }

    func closeSelectLocation() {
        router?.closeSelectLocation()
    }

    func addImage(_ image: UIImage) {
        var currentImages = imageArray.value
        currentImages.append(image)
        imageArray.accept(currentImages)
    }
}

extension RegistLocationInteractor: RegistLocationListener {
    func closeRegistLocation() {
        listener?.closeRegistLocation()
    }
}

extension RegistLocationInteractor: SelectLocationListener {
    func didSelect(data: KakaoSearchDocumentsModel) {
        closeSelectLocation()
        presenter.updateView(with: data)
    }
}
