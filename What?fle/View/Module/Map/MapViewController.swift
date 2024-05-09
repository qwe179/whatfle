//
//  MapViewController.swift
//  What?fle
//
//  Created by 이정환 on 2/24/24.
//

import RIBs
import RxSwift
import UIKit

protocol MapPresentableListener: AnyObject {}

final class MapViewController: UIViewController, MapPresentable, MapViewControllable {

    weak var listener: MapPresentableListener?
}
