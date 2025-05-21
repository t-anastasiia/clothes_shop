//
//  ProductCell.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-05-21.
//

import UIKit
import SkeletonView

class ProductCell: UITableViewCell, SkeletonAnimatableCell {
    static let identifier = "ProductCell"

    let productImageView = UIImageView()
    let titleLabel = UILabel()
    let priceLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.isSkeletonable = true
        productImageView.isSkeletonable = true
        titleLabel.isSkeletonable = true
        priceLabel.isSkeletonable = true
    }

    func configure(with product: Product) {
        hideShimmer()
        titleLabel.text = product.title
        priceLabel.text = "\(product.price) $"
    }

    func showShimmer() {
        [productImageView, titleLabel, priceLabel].forEach {
            $0.showAnimatedGradientSkeleton()
        }
    }

    func hideShimmer() {
        [productImageView, titleLabel, priceLabel].forEach {
            $0.hideSkeleton()
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        hideShimmer()
        productImageView.image = nil
        titleLabel.text = nil
        priceLabel.text = nil
    }
} 
