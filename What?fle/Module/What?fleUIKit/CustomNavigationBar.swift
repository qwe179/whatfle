//
//  CustomNavigationBar.swift
//  What?fle
//
//  Created by 이정환 on 4/6/24.
//

import UIKit
import RxSwift
import SnapKit

protocol CustomNavigationBarDelegate: AnyObject {
    func didTapBackButton()
    func didTapRightButton()
}

class CustomNavigationBar: UIView {
    weak var delegate: CustomNavigationBarDelegate?
    private let disposeBag = DisposeBag()

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
    private let navigationTitle: UILabel = .init()
    private let rightButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        return button
    }()

    init() {
        super.init(frame: .zero)
        setupUI()
        setupAction()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupAction()
    }

    func setNavigationTitle(_ title: String) {
        navigationTitle.attributedText = .makeAttributedString(
            text: title,
            font: .title16XBD,
            textColor: .GrayScale.g900,
            lineHeight: 24
        )
    }

    func setRightButton(title: String) {
        rightButton.isHidden = false
//        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        rightButton.setAttributedTitle(
            // TODO: - 16BD로 추가하고 변경해야함
            .makeAttributedString(
                text: title,
                font: .title16MD,
                textColor: .Core.primary,
                lineHeight: 21
            ),
            for: .normal
        )
//        rightButton.attributedText = .makeAttributedString(
//            text: title,
//            font: .title16XBD,
//            textColor: .GrayScale.g900,
//            lineHeight: 24
//        )
    }

    @objc private func rightButtonTapped() {
        delegate?.didTapRightButton()
    }

    private func setupUI() {
        [backButton, navigationTitle, rightButton].forEach {
            addSubview($0)
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
        rightButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(40)
        }
    }

    private func setupAction() {
        self.backButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] in
                guard let self else { return }
                self.delegate?.didTapBackButton()
            })
            .disposed(by: disposeBag)
    }
}
