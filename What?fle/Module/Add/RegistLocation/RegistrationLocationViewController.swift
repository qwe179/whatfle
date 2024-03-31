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
    func showSelectLocation()
    func closeRegistLocation()
}

private enum ImageState {
    case noImage
    case images
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

    private let scrollView: UIScrollView = .init()
    private let subView: UIView = .init()
    
    private let locationView: UIView = .init()
    private let locationLabel: UILabel = {
        let label: UILabel = .init()
        label.attributedText = .makeAttributedString(
            text: "장소*",
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
        let imageView: UIImageView = .init(image: UIImage(systemName: "plus"))
        let underlineView: UIView = {
            let view: UIView = .init()
            view.backgroundColor = .lineDefault
            return view
        }()
        imageView.tintColor = .textExtralight
        [label, imageView, underlineView].forEach {
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
        underlineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        return control
    }()

    private let tempView: UIView = .init()
    private let addPhotoButton: AddPhotoControl = .init()

    private let visitView: UIView = .init()
    private let visitLabel: UILabel = {
        let label: UILabel = .init()
        label.attributedText = .makeAttributedString(
            text: "방문일자*",
            font: .title16XBD,
            textColor: .textDefault,
            lineHeight: 24,
            additionalAttributes: [(text: "*", attribute: [.foregroundColor: UIColor.red])]
        )
        return label
    }()

    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        return datePicker
    }()
    private lazy var visitTextField: TextFieldWithUnderline = {
        let textField: TextFieldWithUnderline = .init()
        textField.attributedText = NSAttributedString.makeAttributedString(
            text: Date().formattedYYMMDD,
            font: .body14MD,
            textColor: .textDefault,
            lineHeight: 20
        )
        textField.inputView = datePicker
        textField.addDoneButtonOnKeyboard()
        return textField
    }()

    private let memoView: TextViewWithTitle = {
        let view: TextViewWithTitle = .init()
        view.updateUI(title: "메모", placehold: "장소에 대한 기록 남기기")
        return view
    }()

    deinit {
        print("\(self) is being deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupActionBinding()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        listener?.closeRegistLocation()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(customNavigationBar.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(20)
            $0.width.equalTo(UIApplication.shared.width - 48)
        }

        scrollView.addSubview(subView)
        subView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(UIApplication.shared.width - 48)
        }

        scrollView.addSubview(locationView)
        locationView.snp.makeConstraints {
            $0.top.equalTo(customNavigationBar.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
        }
        [locationLabel, addLocationView].forEach {
            locationView.addSubview($0)
        }
        locationLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        addLocationView.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(48)
        }

        scrollView.addSubview(tempView)
        tempView.snp.makeConstraints {
            $0.top.equalTo(addLocationView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(224)
        }
        tempView.addSubview(addPhotoButton)
        addPhotoButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        scrollView.addSubview(visitView)
        visitView.snp.makeConstraints {
            $0.top.equalTo(tempView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
        }
        [visitLabel, visitTextField].forEach {
            visitView.addSubview($0)
        }
        visitLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        visitTextField.snp.makeConstraints {
            $0.top.equalTo(visitLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(112)
        }

        scrollView.addSubview(memoView)
        memoView.snp.makeConstraints {
            $0.top.equalTo(visitView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
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

        self.addLocationView.rx.controlEvent(.touchUpInside)
            .observe(on: MainScheduler.instance)
            .bind { [weak self] in
                guard let self else { return }
                self.listener?.showSelectLocation()
            }
            .disposed(by: disposeBag)

        self.addPhotoButton.rx.controlEvent(.touchUpInside)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self else { return }
                if self.addPhotoButton.buttonState == .noImage {
                    self.addPhotoButton.snp.remakeConstraints {
                        $0.size.equalTo(80)
                        $0.trailing.equalToSuperview().inset(-8)
                        $0.bottom.equalToSuperview().inset(16)
                    }
                } else {
                    self.addPhotoButton.snp.remakeConstraints {
                        $0.edges.equalToSuperview()
                    }
                }
                self.addPhotoButton.toggle()
            })
            .disposed(by: disposeBag)
    }

    @objc private func dateChange(_ sender: UIDatePicker) {
        visitTextField.attributedText = NSAttributedString.makeAttributedString(
            text: sender.date.formattedYYMMDD,
            font: .body14MD,
            textColor: .textDefault,
            lineHeight: 20
        )
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        self.view.frame.origin.y = -keyboardSize.height
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }

}

class AddPhotoControl: UIControl {
    private let stackView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.isUserInteractionEnabled = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()

    private let imageView: UIImageView = {
        let imageView: UIImageView = .init(image: .camera)
        imageView.tintColor = .Core.primary
        return imageView
    }()
    private let label: UILabel = {
        let label: UILabel = .init()
        label.attributedText = .makeAttributedString(
            text: "눌러서 사진 추가",
            font: .title16MD,
            textColor: .Core.primary,
            lineHeight: 24
        )
        return label
    }()
    private let countLabel: UILabel = {
        let label: UILabel = .init()
        label.attributedText = .makeAttributedString(
            text: "(0/10)",
            font: .caption13MD,
            textColor: .Core.primary,
            lineHeight: 20
        )
        return label
    }()

    fileprivate var buttonState: ImageState = .noImage

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    func setupUI() {
        backgroundColor = .Core.p100

        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(183)
        }

        [imageView, label, countLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        imageView.snp.makeConstraints {
            $0.size.equalTo(24)
        }
    }

    fileprivate func toggle() {
        switch buttonState {
        case .noImage:
            buttonState = .images
            stackView.axis = .vertical
            stackView.spacing = 2
            label.isHidden = true
            self.layer.cornerRadius = 40
            self.addShadow(yPoint: 2, blur: 10, opacity: 0.1)
        case .images:
            buttonState = .noImage
            stackView.axis = .horizontal
            stackView.spacing = 8
            label.isHidden = false

            self.removeShadow()
            self.layer.cornerRadius = 0
        }
    }
}
