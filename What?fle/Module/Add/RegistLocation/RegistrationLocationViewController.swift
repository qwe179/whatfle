//
//  RegistLocationViewController.swift
//  What?fle
//
//  Created by 이정환 on 3/5/24.
//

import PhotosUI
import RIBs
import RxCocoa
import RxSwift
import UIKit

protocol RegistLocationPresentableListener: AnyObject {
    var imageArray: BehaviorRelay<[UIImage]> { get }
    var isSelectLocation: BehaviorRelay<Bool> { get }
    func showSelectLocation()
    func closeRegistLocation()
    func addImage(_ image: UIImage)
}

private enum ImageState {
    case noImage
    case images
}

final class RegistLocationViewController: UIViewController, RegistLocationViewControllable {
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

    private let scrollView: UIScrollView = {
        let scrollView: UIScrollView = .init()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.keyboardDismissMode = .onDrag
        return scrollView
    }()
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
    private let addLocationTextField: UITextField = {
        let textField: UITextField = .init()
        textField.isUserInteractionEnabled = false
        return textField
    }()
    private let addLocationImageView: UIImageView = .init(image: UIImage(systemName: "plus"))
    private lazy var addLocationView: UIControl = {
        let control: UIControl = .init()
        addLocationTextField.attributedPlaceholder = .makeAttributedString(
            text: "장소 추가하기",
            font: .title15RG,
            textColor: .textExtralight,
            lineHeight: 24
        )
        let underlineView: UIView = {
            let view: UIView = .init()
            view.backgroundColor = .lineDefault
            return view
        }()
        addLocationImageView.tintColor = .textExtralight
        [addLocationTextField, addLocationImageView, underlineView].forEach {
            control.addSubview($0)
        }
        addLocationTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
        }
        addLocationImageView.snp.makeConstraints {
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

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.itemSize = .init(width: 168, height: 224)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(LocationImageCell.self, forCellWithReuseIdentifier: LocationImageCell.reuseIdentifier)
        return collectionView
    }()

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
        datePicker.locale = Locale(identifier: "ko_KR")
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

    private let saveButton: UIButton = {
        let button: UIButton = .init()
        button.backgroundColor = .Core.primaryDisabled
        button.layer.cornerRadius = 4
        button.setAttributedTitle(
            .makeAttributedString(
                text: "저장",
                font: .title16MD,
                textColor: .white,
                lineHeight: 24
            ),
            for: .normal
        )
        return button
    }()

    deinit {
        print("\(self) is being deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupViewBinding()
        setupActionBinding()
        setupKeyboard()
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
            $0.bottom.equalToSuperview().inset(28)
            $0.width.equalTo(UIApplication.shared.width - 48)
        }

        scrollView.addSubview(subView)
        subView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(UIApplication.shared.width - 48)
        }

        subView.addSubview(locationView)
        locationView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
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

        subView.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(addLocationView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(224)
        }
        view.addSubview(addPhotoButton)
        addPhotoButton.snp.makeConstraints {
            $0.edges.equalTo(collectionView.snp.edges)
        }

        subView.addSubview(visitView)
        visitView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(24)
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
            $0.height.equalTo(48)
        }

        subView.addSubview(memoView)
        memoView.snp.makeConstraints {
            $0.top.equalTo(visitView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
        }

        subView.addSubview(saveButton)
        saveButton.snp.makeConstraints {
            $0.top.equalTo(visitView.snp.bottom).offset(198)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(56)
        }
    }

    private func setupViewBinding() {
        guard let listener else { return }
        listener.imageArray
            .filter { !$0.isEmpty }
            .observe(on: MainScheduler.instance)
            .do(onNext: { [weak self] _ in
                guard let self else { return }
                if self.addPhotoButton.buttonState == .noImage {
                    self.addPhotoButton.snp.remakeConstraints {
                        $0.size.equalTo(80)
                        $0.trailing.equalTo(self.collectionView.snp.trailing).inset(-8)
                        $0.bottom.equalTo(self.collectionView.snp.bottom).inset(16)
                    }
                    self.addPhotoButton.toggle()
                }
            })
            .bind(
                to: collectionView.rx.items(
                    cellIdentifier: LocationImageCell.reuseIdentifier,
                    cellType: LocationImageCell.self
                )
            ) { (_, element, cell) in
                cell.drawCell(image: element)
            }
            .disposed(by: disposeBag)

        let isEnabledObservable = Observable.combineLatest(
            listener.isSelectLocation,
            listener.imageArray.map { !$0.isEmpty },
            memoView.textView.rx.text.orEmpty
        )
        .map { isSelectLocation, isImageArrayNotEmpty, memoText in
            isSelectLocation && isImageArrayNotEmpty && !memoText.isEmpty
        }.share()

        isEnabledObservable
            .bind(to: saveButton.rx.isEnabled)
            .disposed(by: disposeBag)

        isEnabledObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] bool in
                guard let self else { return }
                self.saveButton.backgroundColor = bool ? .Core.primary : .Core.primaryDisabled
                saveButton.setAttributedTitle(
                    .makeAttributedString(
                        text: "저장",
                        font: .title16MD,
                        textColor: bool ? .black : .white,
                        lineHeight: 24
                    ),
                    for: .normal
                )
            })
            .disposed(by: disposeBag)
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
            .filter { [weak self] _ in (self?.listener?.imageArray.value.count ?? 10) < 10}
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self else { return }
                self.dismissKeyboard()
                var configuration = PHPickerConfiguration()
                configuration.selectionLimit = 10 - (self.listener?.imageArray.value.count ?? 0)
                configuration.filter = .any(of: [.images])
                let picker = PHPickerViewController(configuration: configuration)
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)

        self.saveButton.rx.controlEvent(.touchUpInside)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                // TODO: - 저장로직 추가해야함
                print("저장~!")
            })
            .disposed(by: disposeBag)
    }
}

extension RegistLocationViewController {
    private func setupKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        tap.delegate = self
        view.addGestureRecognizer(tap)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
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

extension RegistLocationViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return !(touch.view is UIControl)
    }
}

final class AddPhotoControl: UIControl {
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

    fileprivate func updatePhoto(count: Int) {
        countLabel.attributedText = .makeAttributedString(
            text: "(\(count)/10)",
            font: .caption13MD,
            textColor: .Core.primary,
            lineHeight: 20)
    }
}

extension RegistLocationViewController: RegistLocationPresentable {
    func updateView(with data: KakaoSearchDocumentsModel) {
        addLocationTextField.attributedText = .makeAttributedString(
            text: "장소 이름 / \(data.placeName)",
            font: .title15RG,
            textColor: .textDefault,
            lineHeight: 24
        )
        addLocationImageView.image = .change
        listener?.isSelectLocation.accept(true)
    }
}

extension RegistLocationViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        guard !results.isEmpty else { return }

        for itemProvider in results.map ({ $0.itemProvider }) where itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                guard let self, let image = image as? UIImage, let listener = self.listener else { return }
                DispatchQueue.main.async {
                    listener.addImage(image)
                    self.addPhotoButton.updatePhoto(count: listener.imageArray.value.count)
                }
            }
        }
    }
}
