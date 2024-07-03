//
//  LoginInteractor.swift
//  What?fle
//
//  Created by 23 09 on 7/2/24.
//

import RIBs
import RxSwift
import RxKakaoSDKCommon
import KakaoSDKUser
import RxKakaoSDKUser
import KakaoSDKAuth
import Foundation

protocol LoginRouting: ViewableRouting {
    func routeToTermsOfUse()
}

protocol LoginPresentable: Presentable {
    var listener: LoginPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol LoginListener: AnyObject {
    func loginWithKakao()
}

final class LoginInteractor: PresentableInteractor<LoginPresentable>, LoginInteractable, LoginPresentableListener {

    weak var router: LoginRouting?
    weak var listener: LoginListener?
    
    private let networkService: NetworkServiceDelegate
    private let disposeBag = DisposeBag()

    deinit {
        print("\(self) is being deinit")
    }

    init(presenter: LoginPresentable, networkService: NetworkServiceDelegate) {
        self.networkService = networkService
        super.init(presenter: presenter)
        presenter.listener = self
    }

    func loginWithKakao() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.rx.loginWithKakaoTalk()
                .subscribe(onNext:{ [weak self] oauthToken in
                    guard let self = self else { return }
                    self.getKaKaoUserInfo(oauthToken: oauthToken)
                }, onError: { error in
                    print("loginWithKakaoTalk() error: \(error.localizedDescription)")
                })
                .disposed(by: disposeBag)
        }
    }

    func getKaKaoUserInfo(oauthToken: OAuthToken) {
        UserApi.shared.rx.me()
            .subscribe (onSuccess:{ [weak self] user in
                guard let self = self else { return }
                self.loginServer(user: user)
                    .subscribe(onSuccess: { _ in
                        self.router?.routeToTermsOfUse()
                    })
            }, onFailure: {error in
                // TODO: 로그인 실패 처리
                print(error)
            })
            .disposed(by: disposeBag)
    }

    func loginServer(user: User) -> Single<LoginModel> {
        networkService.request(WhatfleAPI.kakaoLogin(user))
        .map { response -> LoginModel in
            return try JSONDecoder().decode(LoginModel.self, from: response.data)
        }
    }
}
