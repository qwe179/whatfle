//
//  TextViewWithTitle.swift
//  What?fle
//
//  Created by JeongHwan Lee on 3/31/24.
//

import UIKit

class TextViewWithTitle: UIView {
    private let titleLabel: UILabel = .init()
    let textView: UITextView = {
        let textView: UITextView = .init()
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 0)
        textView.font = .body14MD
        textView.contentInset = .zero
        return textView
    }()
    private let placeholdLabel: UILabel = {
        let label: UILabel = .init()
        return label
    }()
    private let underlineView: UIView = {
        let view: UIView = .init()
        view.backgroundColor = .lineDefault
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupUI()
    }

    func setupUI() {
        textView.delegate = self

        [titleLabel, textView, placeholdLabel, underlineView].forEach {
            addSubview($0)
        }
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.equalTo(24)
        }
        textView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(48)
        }
        placeholdLabel.snp.makeConstraints {
            $0.centerY.equalTo(textView)
            $0.leading.equalToSuperview()
        }
        underlineView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }

    func updateUI(title: String, isRequired: Bool = true, placehold: String = "") {
        titleLabel.attributedText = .makeAttributedString(
            text: title + (isRequired ? "*" : ""),
            font: .title16XBD,
            textColor: .textDefault,
            lineHeight: 24,
            additionalAttributes: isRequired ? [(text: "*", attribute: [.foregroundColor: UIColor.red])] : nil)

        placeholdLabel.attributedText = .makeAttributedString(
            text: placehold,
            font: .body14MD,
            textColor: .textExtralight,
            lineHeight: 20,
            lineSpacing: 5
        )
        print("Line Height: \(UIFont.body14MD.lineHeight)")
    }
}

extension TextViewWithTitle: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        underlineView.backgroundColor = .Core.primary
        placeholdLabel.isHidden = true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        underlineView.backgroundColor = .lineDefault
        placeholdLabel.isHidden = !textView.text.isEmpty
    }

    func textViewDidChange(_ textView: UITextView) {
        let numberOfLines = Int((textView.contentSize.height - 28) / 17)
        textView.snp.updateConstraints {
            $0.height.equalTo(20 * (numberOfLines >= 3 ? 3 : numberOfLines) + 28)
        }
    }
}
