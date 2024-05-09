//
//  AddCollectionInteractor.swift
//  What?fle
//
//  Created by 이정환 on 4/6/24.
//

import Foundation
import RIBs
import RxSwift
import RxCocoa

protocol AddCollectionRouting: ViewableRouting {}

protocol AddCollectionPresentable: Presentable {
    var listener: AddCollectionPresentableListener? { get set }
}

protocol AddCollectionListener: AnyObject {
    func closeAddCollection()
    func popCurrentRIB()
    func sendDataToRegistCollection(data: EditSelectedCollectionData)
}

final class AddCollectionInteractor: PresentableInteractor<AddCollectionPresentable>,
                                     AddCollectionInteractable,
                                     AddCollectionPresentableListener {
    weak var router: AddCollectionRouting?
    weak var listener: AddCollectionListener?
    private let networkService: NetworkServiceDelegate
    private let disposeBag = DisposeBag()

    var locationTotalCount: BehaviorRelay<Int> = .init(value: 0)
    var registeredLocations: BehaviorRelay<[RegisteredLocation]> = .init(value: [])
    var selectedLocations: BehaviorRelay<[(IndexPath, KakaoSearchDocumentsModel)]> = .init(value: [])
    var editSelectedCollectionData: EditSelectedCollectionData?

    deinit {
        print("\(self) is being deinit")
    }

    init(presenter: AddCollectionPresentable, networkService: NetworkServiceDelegate, data: EditSelectedCollectionData?) {
        self.networkService = networkService
        if let data {
            registeredLocations.accept(data.registeredLocations)
            selectedLocations.accept(data.selectedLocations)
        }

        super.init(presenter: presenter)
        presenter.listener = self
    }

    func closeAddCollection() {
        listener?.closeAddCollection()
    }

    func popCurrentRIB() {
        listener?.popCurrentRIB()
    }

    func showRegistLocation() {
        listener?.closeAddCollection()
    }

    func retriveRegistLocation() {
        LoadingIndicatorService.shared.showLoading()
        networkService.request(WhatfleAPI.retriveRegistLocation)
            .filter { _ in LoadingIndicatorService.shared.isLoading() }
            .map { response -> RegisteredLocationModel in
                let retriveResults = try JSONDecoder().decode(RegisteredLocationModel.self, from: response.data)
                return retriveResults
            }
            .subscribe(onNext: { [weak self] result in
                guard let self else { return }
                self.registeredLocations.accept(result.registLocations)
                self.locationTotalCount.accept(result.totalCount)
                LoadingIndicatorService.shared.hideLoading()
            }, onError: { error in
                print("Error: \(error)")
            })
            .disposed(by: disposeBag)
    }

    func selectItem(with indexPath: IndexPath) {
        guard let data = registeredLocations.value[safe: indexPath.section]?.locations[safe: indexPath.row] else { return }
        selectedLocations.accept(selectedLocations.value + [(indexPath, data)])
    }

    func deselectItem(with indexPath: IndexPath) {
        guard (registeredLocations.value[safe: indexPath.section]?.locations[safe: indexPath.row]) != nil else { return }
        selectedLocations.accept(selectedLocations.value.filter { $0.0 != indexPath })
    }

    func showRegistCollection() {
        let data: EditSelectedCollectionData = .init(
            registeredLocations: registeredLocations.value,
            selectedLocations: selectedLocations.value
        )
        self.listener?.sendDataToRegistCollection(data: data)
    }

    func sendDataToAddCollection(data: [KakaoSearchDocumentsModel]) {}
}
