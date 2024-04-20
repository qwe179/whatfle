//
//  RegistCollectionInteractor.swift
//  What?fle
//
//  Created by 이정환 on 4/17/24.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit

protocol RegistCollectionRouting: ViewableRouting {}

protocol RegistCollectionPresentable: Presentable {
    var listener: RegistCollectionPresentableListener? { get set }
}

protocol RegistCollectionListener: AnyObject {
    
}

final class RegistCollectionInteractor: PresentableInteractor<RegistCollectionPresentable>,
                                        RegistCollectionInteractable,
                                        RegistCollectionPresentableListener {

    weak var router: RegistCollectionRouting?
    weak var listener: RegistCollectionListener?
    var selectedImage = BehaviorRelay<UIImage?>(value: nil)

    private let networkService: NetworkServiceDelegate
    private let disposeBag = DisposeBag()

    init(presenter: RegistCollectionPresentable, networkService: NetworkServiceDelegate) {
        self.networkService = networkService
        super.init(presenter: presenter)
        presenter.listener = self
    }

    func addImage(_ image: UIImage) {
        self.selectedImage.accept(image)
    }
    
    func removeImage() {
        self.selectedImage.accept(nil)
    }
}

extension RegistCollectionInteractor: RegistCollectionListener {
    
}
