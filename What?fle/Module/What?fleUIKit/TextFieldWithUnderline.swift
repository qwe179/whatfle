//
//  TextFieldWithUnderline.swift
//  What?fle
//
//  Created by JeongHwan Lee on 3/31/24.
//

import SnapKit
import UIKit

class TextFieldWithUnderline: UITextField {
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

    private func setupUI() {
        self.delegate = self

        addSubview(underlineView)
        underlineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func activateUnderline() {
        underlineView.backgroundColor = .Core.primary
    }

    private func deactivateUnderline() {
        underlineView.backgroundColor = .lineDefault
    }
}

extension TextFieldWithUnderline: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activateUnderline()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        deactivateUnderline()
    }
}
