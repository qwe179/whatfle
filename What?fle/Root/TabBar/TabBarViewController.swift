//
//  TabBarViewController.swift
//  What?fle
//
//  Created by 이정환 on 2/23/24.
//

import RIBs
import RxSwift
import UIKit

protocol TabBarPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class TabBarViewController: UIViewController, TabBarPresentable, TabBarViewControllable {

    weak var listener: TabBarPresentableListener?
}
