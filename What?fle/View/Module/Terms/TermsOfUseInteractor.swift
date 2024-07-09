//
//  TermsOfUseInteractor.swift
//  What?fle
//
//  Created by 23 09 on 7/3/24.
//

import RIBs
import RxSwift

protocol TermsOfUseRouting: ViewableRouting {
}

protocol TermsOfUsePresentable: Presentable {
    var listener: TermsOfUsePresentableListener? { get set }
}

protocol TermsOfUseListener: AnyObject {
}

final class TermsOfUseInteractor: PresentableInteractor<TermsOfUsePresentable>, TermsOfUseInteractable, TermsOfUsePresentableListener {

    weak var router: TermsOfUseRouting?
    weak var listener: TermsOfUseListener?

    override init(presenter: TermsOfUsePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
}
