//
//  CatalogProductCell.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-05-06.
//

import UIKit
import SnapKit

class CatalogProductCell: UITableViewCell {

    private let imageLoader = UIImageLoader()

    static let identifier = "CatalogProductCell"

    internal let productImageView = UIImageView()
    internal let titleLabel = UILabel()
    internal let descriptionLabel = UILabel()
    internal let priceLabel = UILabel()
    internal let priceContainer = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    internal func setupUI() {
        selectionStyle = .none

        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byTruncatingTail

        descriptionLabel.font = .systemFont(ofSize: 15)
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 3
        descriptionLabel.lineBreakMode = .byTruncatingTail

        priceLabel.font = .boldSystemFont(ofSize: 18)
        priceLabel.textColor = UIColor(named: "BrownDark")

        priceContainer.backgroundColor = UIColor(named: "Beige")
        priceContainer.layer.cornerRadius = 8
        priceContainer.addSubview(priceLabel)

        [productImageView, titleLabel, descriptionLabel, priceContainer].forEach {
            contentView.addSubview($0)
        }

        productImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(120)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalTo(productImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalTo(titleLabel)
        }

        priceContainer.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(12)
            $0.leading.equalTo(titleLabel)
            $0.bottom.lessThanOrEqualToSuperview().inset(16)
        }

        priceLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12))
        }
    }

    func configure(with product: Product) {
        titleLabel.text = product.title
        descriptionLabel.text = product.description
        priceLabel.text = "\(product.price) $"

        imageLoader.loadImage(from: product.image) { [weak self] image in
            DispatchQueue.main.async {
                self?.productImageView.image = image
            }
        }
    }
}

