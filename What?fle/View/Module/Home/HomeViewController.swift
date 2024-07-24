//
//  HomeViewController.swift
//  What?fle
//
//  Created by 이정환 on 2/24/24.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol HomePresentableListener: AnyObject {
    func goToLogin()
}

final class HomeViewController: UIViewController, HomePresentable, HomeViewControllable {
    private let loginButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("login", for: . normal)
        btn.setTitleColor(.black, for: .normal)
        btn.tintColor = .gray
        return btn
    }()
    
    weak var listener: HomePresentableListener?
    let disposeBag = DisposeBag()

    deinit {
        print("\(self) is being deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(loginButton)
        loginButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        loginButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self else { return }
                self.listener?.goToLogin()
            })
            .disposed(by: disposeBag )
    }
}
