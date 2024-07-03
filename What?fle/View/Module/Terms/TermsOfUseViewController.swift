//
//  TermsOfUseViewController.swift
//  What?fle
//
//  Created by 23 09 on 7/3/24.
//

import RIBs
import RxSwift
import UIKit

protocol TermsOfUsePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class TermsOfUseViewController: UIViewController, TermsOfUsePresentable, TermsOfUseViewControllable {

    weak var listener: TermsOfUsePresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
}
