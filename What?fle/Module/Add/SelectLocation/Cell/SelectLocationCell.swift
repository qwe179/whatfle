//
//  SelectLocationCell.swift
//  What?fle
//
//  Created by 이정환 on 3/21/24.
//

import SnapKit
import UIKit

final class SelectLocationCell: UITableViewCell {
    static let reuseIdentifier = "SelectLocationCell"

    private let placeImage: UIView = {
        let view: UIView = .init()
        let imageView: UIImageView = .init(image: .placehold)
        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lineExtralight.cgColor
        return view
    }()

    private let titleView: UIView = .init()

    private let titleLabel: UILabel = {
        let label: UILabel = .init()
        label.numberOfLines = 2
        label.font = .body14SB
        return label
    }()

    private let subTitleLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .caption12RG
        label.textColor = .textExtralight
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLayout()
        self.selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }

    private func setupLayout() {
        contentView.addSubview(self.placeImage)
        self.placeImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.size.equalTo(64)
        }
        contentView.addSubview(self.titleView)
        self.titleView.snp.makeConstraints {
            $0.centerY.equalTo(self.placeImage.snp.centerY)
            $0.leading.equalTo(self.placeImage.snp.trailing).offset(16)
            $0.trailing.equalToSuperview()
        }
        self.titleView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        self.titleView.addSubview(self.subTitleLabel)
        self.subTitleLabel.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(self.titleLabel.snp.bottom).offset(4)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    func drawCell(model: KakaoSearchDocumentsModel) {
        titleLabel.text = model.placeName
        subTitleLabel.text = model.addressName
    }
}
