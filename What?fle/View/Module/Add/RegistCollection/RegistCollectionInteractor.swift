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

protocol RegistCollectionRouting: ViewableRouting {
    func routeToRegistCollection(data: EditSelectedCollectionData)
    func closeCurrentRIB()
}

protocol RegistCollectionPresentable: Presentable {
    var listener: RegistCollectionPresentableListener? { get set }
}

protocol RegistCollectionListener: AnyObject {}

final class RegistCollectionInteractor: PresentableInteractor<RegistCollectionPresentable>,
                                        RegistCollectionInteractable,
                                        RegistCollectionPresentableListener {
    weak var router: RegistCollectionRouting?
    weak var listener: RegistCollectionListener?
    var selectedImage: BehaviorRelay<UIImage?> = .init(value: nil)
    let selectedLocations: BehaviorRelay<[KakaoSearchDocumentsModel]>
    var editSelectedCollectionData: EditSelectedCollectionData

    private let networkService: NetworkServiceDelegate

    private let disposeBag = DisposeBag()

    deinit {
        print("\(self) is being deinit")
    }

    init(
        presenter: RegistCollectionPresentable,
        networkService: NetworkServiceDelegate,
        data: EditSelectedCollectionData
    ) {
        self.networkService = networkService
        self.editSelectedCollectionData = data
        self.selectedLocations = .init(value: data.selectedLocations.map { $0.1 })
        super.init(presenter: presenter)
        presenter.listener = self
    }

    func addImage(_ image: UIImage) {
//        self.selectedImage.accept(image)
    }

    func removeImage() {
//        self.selectedImage.accept(nil)
    }

    func showEditCollection() {
        self.router?.routeToRegistCollection(data: editSelectedCollectionData)
    }

    func closeCurrentRIB() {
        self.router?.closeCurrentRIB()
    }

    func sendDataToRegistCollection(data: EditSelectedCollectionData) {}

    func closeAddCollection() {
        self.router?.closeCurrentRIB()
    }

    func popCurrentRIB() {}
}
