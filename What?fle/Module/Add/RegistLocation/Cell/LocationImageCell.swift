//
//  LocationImageCell.swift
//  What?fle
//
//  Created by 이정환 on 4/2/24.
//

import SnapKit
import UIKit

final class LocationImageCell: UICollectionViewCell {
    static let reuseIdentifier = "LocationImageCell"

    private let placeImage: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }

    private func setupLayout() {
        contentView.layer.cornerRadius = 4
        contentView.clipsToBounds = true

        contentView.addSubview(self.placeImage)
        self.placeImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func drawCell(image: UIImage) {
        placeImage.image = image
    }
}
