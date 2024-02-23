//
//  RootViewController.swift
//  What?fle
//
//  Created by 이정환 on 2/23/24.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: AnyObject {}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {

    weak var listener: RootPresentableListener?
}
