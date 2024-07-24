//
//  HomeInteractor.swift
//  What?fle
//
//  Created by 이정환 on 2/24/24.
//

import RIBs
import RxSwift

protocol HomeRouting: ViewableRouting {
    func dismissLogin()
    func routeToLogin()
}

protocol HomePresentable: Presentable {
    var listener: HomePresentableListener? { get set }
}

protocol HomeListener: AnyObject {}

final class HomeInteractor: PresentableInteractor<HomePresentable>, HomeInteractable, HomePresentableListener {
    var router: (any HomeRouting)?
    var listener: (any HomeListener)?

    private let networkService: NetworkServiceDelegate
    private let supabaseService: SupabaseServiceDelegate

    init(presenter: HomePresentable, networkService: NetworkServiceDelegate, supabaseService: SupabaseServiceDelegate) {
        self.networkService = networkService
        self.supabaseService = supabaseService
        super.init(presenter: presenter)
        presenter.listener = self
    }

    func goToLogin() {
        router?.routeToLogin()
    }
}

extension HomeInteractor: LoginListener {
    func dismissLogin() {
        router?.dismissLogin()
    }
}
