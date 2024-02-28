//
//  NetworkManager.swift
//  What?fle
//
//  Created by 이정환 on 2/28/24.
//

import Foundation
import Moya
import RxSwift

final class NetworkManager {
    static let shared = NetworkManager()

    let provider = MoyaProvider<KakaoSearchAPI>()

    private init() {}

    func request(_ target: KakaoSearchAPI) -> Observable<Response> {
        return Observable.create { observer in
            let cancellable = self.provider.request(target) { result in
                switch result {
                case .success(let response):
                    observer.onNext(response)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }

            return Disposables.create {
                cancellable.cancel()
            }
        }
    }
}
