//
//  RecommendedProductCell.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-05-21.
//

import UIKit
import SnapKit
import SkeletonView

class RecommendedProductCell: UICollectionViewCell, SkeletonAnimatableCell {
    static let identifier = "RecommendedProductCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.isSkeletonable = true
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(named: "Text/Primary")
        label.numberOfLines = 2
        label.isSkeletonable = true
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "BrownLight")
        label.isSkeletonable = true
        return label
    }()

    private let imageLoader = UIImageLoader()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        contentView.isSkeletonable = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)

        imageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(120)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
        }

        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview()
        }
    }

    func configure(with product: Product) {
        hideShimmer()
        titleLabel.text = product.title
        priceLabel.text = "\(product.price) $"
        imageLoader.loadImage(from: product.image) { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
    }

    func showShimmer() {
        [imageView, titleLabel, priceLabel].forEach {
            $0.showAnimatedGradientSkeleton()
        }
    }

    func hideShimmer() {
        [imageView, titleLabel, priceLabel].forEach {
            $0.hideSkeleton()
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        hideShimmer()
        imageView.image = nil
        titleLabel.text = nil
        priceLabel.text = nil
    }
} 
