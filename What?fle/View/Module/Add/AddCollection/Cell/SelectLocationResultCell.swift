//
//  SelectLocationResultCell.swift
//  What?fle
//
//  Created by 이정환 on 4/7/24.
//

import RxSwift
import RxCocoa
import SnapKit
import UIKit

final class SelectLocationResultCell: UICollectionViewCell {
    static let reuseIdentifier = "SelectLocationResultCell"

    private let placeImage: UIView = {
        let view: UIView = .init()
        let imageView: UIImageView = .init(image: .placehold)
        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        view.layer.cornerRadius = 4
        return view
    }()

    private let titleLabel: UILabel = .init()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }

    private func setupLayout() {
        contentView.addSubview(self.placeImage)
        self.placeImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(self.placeImage.snp.width)
        }

        contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.placeImage.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    func drawCell(model: KakaoSearchDocumentsModel) {
        titleLabel.attributedText = .makeAttributedString(
            text: model.placeName,
            font: .caption12RG,
            textColor: .textLight,
            lineHeight: 20
        )
    }
}
