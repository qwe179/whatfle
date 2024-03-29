//
//  SelectLocationInteractor.swift
//  What?fle
//
//  Created by 이정환 on 2/25/24.
//

import RIBs
import RxSwift
import RxCocoa
import Foundation

protocol SelectLocationRouting: ViewableRouting {}

protocol SelectLocationPresentable: Presentable {
    var listener: SelectLocationPresentableListener? { get set }
}

protocol SelectLocationListener: AnyObject {
//    func closeSelectLocationRIB()
}

final class SelectLocationInteractor: PresentableInteractor<SelectLocationPresentable>,
                                      SelectLocationInteractable,
                                      SelectLocationPresentableListener {
    weak var router: SelectLocationRouting?
    weak var listener: SelectLocationListener?

    private let disposeBag = DisposeBag()
    var searchResultArray = BehaviorRelay<[KakaoSearchDocumentsModel]>(value: [])
    var recentKeywordArray = BehaviorRelay<[String]>(value: UserDefaultsManager.recentSearchLoad())

    deinit {
        print("\(Self.self) is being deinitialized")
    }

    override init(presenter: SelectLocationPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    func performSearch(with query: String, more: Bool) {
        NetworkManager.shared.request(.search(query, currentPage(more: more)))
            .filter { _ in LoadingIndicatorService.shared.isLoading() }
            .do(onSubscribe: {
                    LoadingIndicatorService.shared.showLoading()
                }, onDispose: {
                    LoadingIndicatorService.shared.hideLoading()
                })
            .do(onNext: { _ in
                UserDefaultsManager.recentSearchSave(searchText: query)
            })
            .map { response -> [KakaoSearchDocumentsModel] in
                let searchResults = try JSONDecoder().decode(KakaoSearchModel.self, from: response.data)
                return searchResults.documents
            }
            .filter { [weak self] in self?.searchResultArray.value.last == $0.last }
            .subscribe(onNext: { [weak self] result in
                guard let self else { return }
                if more {
                    self.searchResultArray.accept(self.searchResultArray.value + result)
                } else {
                    self.searchResultArray.accept(result)
                }
            }, onError: { error in
                print("Error: \(error)")
            })
            .disposed(by: disposeBag)
    }

    func closeView() {
//        print("listener", listener)
//        self.listener?.closeSelectLocationRIB()
    }

    func deleteItem(at index: Int) {
        let updateRecentSearch = UserDefaultsManager.recentSearchRemove(index: index)
        recentKeywordArray.accept(updateRecentSearch)
    }

    func allDeleteItem() {
        UserDefaultsManager.recentSearchAllRemove()
        recentKeywordArray.accept([])
    }
}

extension SelectLocationInteractor {
    private func currentPage(more: Bool) -> Int {
        if !more {
            return 1
        }

        if searchResultArray.value.isEmpty {
            return 1
        } else {
            return (searchResultArray.value.count / 15) + 1
        }
    }
}
