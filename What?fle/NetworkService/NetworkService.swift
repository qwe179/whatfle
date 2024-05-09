//
//  NetworkService.swift
//  What?fle
//
//  Created by 이정환 on 2/28/24.
//

import Foundation
import Moya
import RxSwift

protocol NetworkServiceDelegate: AnyObject {
    func request<T: TargetType>(_ target: T) -> Observable<Response>
}

final class NetworkService: NetworkServiceDelegate {
    private let provider: MoyaProvider<MultiTarget>

    init(isStubbing: Bool = true) {
        if isStubbing {
            self.provider = MoyaProvider<MultiTarget>(stubClosure: MoyaProvider.immediatelyStub)
        } else {
            self.provider = MoyaProvider<MultiTarget>()
        }
    }

    func request<T: TargetType>(_ target: T) -> Observable<Response> {
        return Observable.create { [weak provider] observer in
            let requestTarget = MultiTarget(target)
            let cancellable = provider?.request(requestTarget) { result in
                switch result {
                case .success(let response):
                    observer.onNext(response)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                cancellable?.cancel()
            }
        }
    }
}
