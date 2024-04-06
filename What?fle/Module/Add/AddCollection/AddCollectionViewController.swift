//
//  AddCollectionViewController.swift
//  What?fle
//
//  Created by 이정환 on 4/6/24.
//

import RIBs
import RxCocoa
import RxSwift
import UIKit

protocol AddCollectionPresentableListener: AnyObject {
    func closeAddCollection()
    func showRegistLocation()
}

enum AddCollectionType {
    case limated(Int)
    case available
}

final class AddCollectionViewController: UIViewController, AddCollectionPresentable, AddCollectionViewControllable {
    weak var listener: AddCollectionPresentableListener?
    private let disposeBag = DisposeBag()

    private lazy var customNavigationBar: CustomNavigationBar = {
        let view: CustomNavigationBar = .init()
        view.setNavigationTitle("컬렉션 생성")
        view.delegate = self
        return view
    }()

    private let registLocationLabel: UILabel = {
        let label: UILabel = .init()
//        label.attributedText = .makeAttributedString(
//            text: "(현재 등록장소 4/4)",
//            font: .caption12BD,
//            textColor: .textExtralight,
//            lineHeight: 20
//        )
        return label
    }()

    private lazy var limitedView: UIView = {
        let view: UIView = .init()
        let imageView: UIImageView = .init(image: .warningCircleFilled)
        imageView.tintColor = .textExtralight
        let placeholdLabel: UILabel = .init()
        placeholdLabel.numberOfLines = 2
        placeholdLabel.attributedText = .makeAttributedString(
            text: "컬렉션을 만들기 위해\n최소 4군데의 장소를 기록해야해요.",
            font: .title15RG,
            textColor: .textLight,
            lineHeight: 24,
            alignment: .center
        )
        [imageView, placeholdLabel, registLocationLabel, limitedButton].forEach {
            view.addSubview($0)
        }
        imageView.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.size.equalTo(40)
        }
        placeholdLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
        }
        registLocationLabel.snp.makeConstraints {
            $0.top.equalTo(placeholdLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        limitedButton.snp.makeConstraints {
            $0.top.equalTo(registLocationLabel.snp.bottom).offset(48)
            $0.centerX.bottom.equalToSuperview()
            $0.height.equalTo(48)
        }
        return view
    }()

    private lazy var limitedButton: UIControl = {
        let control: UIControl = .init()
        control.layer.cornerRadius = 4
        control.backgroundColor = .white
        control.addShadow(
            yPoint: 2,
            blur: 10,
            color: .init(
                displayP3Red: 0,
                green: 62/255,
                blue: 135/255,
                alpha: 0.1
            )
        )
        let label: UILabel = .init()
        label.attributedText = .makeAttributedString(
            text: "장소 기록하러 가기",
            // TODO: - 디자인 전달받으면 수정
            font: .suit(size: 14, weight: .medium),
            textColor: .Core.approve,
            lineHeight: 20
        )
        let imageView: UIImageView = .init(image: .bright)
        [label, imageView].forEach {
            control.addSubview($0)
        }
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-4)
            $0.size.equalTo(24)
            $0.leading.equalTo(label.snp.trailing).offset(4)
            $0.trailing.equalToSuperview().inset(8)
        }
        return control
    }()

    private var screenType: AddCollectionType = .limated(0) {
        didSet {
            switch screenType {
            case .limated(let count):
                registLocationLabel.attributedText = .makeAttributedString(
                    text: "(현재 등록장소 \(count)/4)",
                    font: .caption12BD,
                    textColor: .textExtralight,
                    lineHeight: 20
                )
            case .available:
                break
            }
        }
    }

    init(screenType: AddCollectionType) {
        self.screenType = screenType
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.screenType = .limated(0)
        super.init(coder: coder)
    }

    deinit {
        print("\(self) is being deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupViewBinding()
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(customNavigationBar)
        customNavigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(54)
        }

        view.addSubview(limitedView)
        limitedView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private func setupViewBinding() {
        limitedButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] in
                guard let self else { return }
                self.navigationController?.popViewController(animated: true)
                self.listener?.showRegistLocation()
            })
            .disposed(by: disposeBag)
    }
}

extension AddCollectionViewController: CustomNavigationBarDelegate {
    func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
        listener?.closeAddCollection()
    }

    func didTapRightButton() {}
}
