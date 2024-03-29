//
//  RegistLocationViewController.swift
//  What?fle
//
//  Created by 이정환 on 3/5/24.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit

protocol RegistLocationPresentableListener: AnyObject {
    func showSelectLocationRIB()
    func closeRegistLocationRIB()
}

final class RegistLocationViewController: UIViewController, RegistLocationPresentable, RegistLocationViewControllable {

    weak var listener: RegistLocationPresentableListener?
    private let disposeBag = DisposeBag()

    private let customNavigationBar: UIView = {
        let view: UIView = .init()
        return view
    }()

    private let backButton: UIControl = {
        let control: UIControl = .init()
        let image: UIImageView = .init(image: .arrowLeftLine)
        control.addSubview(image)
        image.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.center.equalToSuperview()
        }
        return control
    }()

    private let navigationTitle: UILabel = {
        let label: UILabel = .init()
        label.attributedText = .makeAttributedString(
            text: "장소 기록하기",
            font: .title16XBD,
            textColor: .GrayScale.g900,
            lineHeight: 24
        )
        return label
    }()

    private let locationView: UIView = .init()
    private let locationLabel: UILabel = {
        let label: UILabel = .init()
        label.attributedText = .makeAttributedString(
            text: "장소",
            font: .title16XBD,
            textColor: .textDefault,
            lineHeight: 24,
            additionalAttributes: [(text: "*", attribute: [.foregroundColor: UIColor.red])]
        )
        return label
    }()
    private let addLocationView: UIControl = {
        let control: UIControl = .init()
        let label: UILabel = .init()
        label.attributedText = .makeAttributedString(
            text: "장소 추가하기",
            font: .title15RG,
            textColor: .textExtralight,
            lineHeight: 24
        )
        let imageView: UIImageView = .init(image: .addLine)
        imageView.tintColor = .textExtralight
        [label, imageView].forEach {
            control.addSubview($0)
        }
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
        }
        imageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        return control
    }()

    deinit {
        print("\(self) is being deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupActionBinding()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        listener?.closeRegistLocationRIB()
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(customNavigationBar)
        customNavigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(54)
        }
        [backButton, navigationTitle].forEach {
            customNavigationBar.addSubview($0)
        }
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(40)
        }
        navigationTitle.snp.makeConstraints {
            $0.leading.equalTo(backButton.snp.trailing).offset(4)
            $0.centerY.equalToSuperview()
        }
    }

    private func setupActionBinding() {
        self.backButton.rx.controlEvent(.touchUpInside)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self else { return }
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
