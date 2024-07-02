//
//  MyPageViewController.swift
//  What?fle
//
//  Created by 23 09 on 7/2/24.
//

import RIBs
import RxSwift
import UIKit

protocol MyPagePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class MyPageViewController: UIViewController, MyPagePresentable, MyPageViewControllable {

    weak var listener: MyPagePresentableListener?
}
