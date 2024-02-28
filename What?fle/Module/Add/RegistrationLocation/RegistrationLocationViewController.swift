//
//  RegistrationLocationViewController.swift
//  What?fle
//
//  Created by 이정환 on 3/5/24.
//

import RIBs
import RxSwift
import UIKit

protocol RegistrationLocationPresentableListener: AnyObject {}

final class RegistrationLocationViewController: UIViewController, RegistrationLocationPresentable {

    weak var listener: RegistrationLocationPresentableListener?
    
    deinit {
        print("\(self) is being deinit")
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.view.backgroundColor = .red
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RegistrationLocationViewController: RegistrationLocationViewControllable {
    func push(viewController: ViewControllable) {
        self.navigationController?.pushViewController(viewController.uiviewController, animated: true)
    }

    func pushWithOutTabBar(with viewController: ViewControllable, animated: Bool) {
        viewController.uiviewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController.uiviewController, animated: animated)
    }
}
