//
//  MyPageViewController.swift
//  What?fle
//
//  Created by 23 09 on 7/2/24.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol MyPagePresentableListener: AnyObject {

}

final class MyPageViewController: UIViewController, MyPagePresentable, MyPageViewControllable {
    private let alarmButton: UIButton = {
        let button = UIButton()
       // button.setImage(, for: <#T##UIControl.State#>)
        return button
    }()
    private lazy var customNavigationBar: CustomNavigationBar = {
        let view: CustomNavigationBar = .init()
        view.setNavigationTitle("장소 기록하기")
        return view
    }()
    private let label = {
        let label = UILabel()
        label.text = "test"
        return label
    }()

    weak var listener: MyPagePresentableListener?

    deinit {
        print("\(self) is being deinit")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
}

extension MyPageViewController {
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(customNavigationBar)
        customNavigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(54)
        }

        view.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
