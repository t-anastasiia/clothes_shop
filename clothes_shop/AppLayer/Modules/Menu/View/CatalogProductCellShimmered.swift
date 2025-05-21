//
//  CatalogProductCellShimmered.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-06-10.
//

import UIKit
import SnapKit
import SkeletonView

class CatalogProductCellShimmered: UITableViewCell {
    static let identifier = "CatalogProductCellShimmered"

    private let productImageViewPlaceholder: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.isSkeletonable = true
        return view
    }()

    private let titleLabelPlaceholder: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 4
        view.isSkeletonable = true
        return view
    }()

    private let descriptionLabelPlaceholder: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 4
        view.isSkeletonable = true
        return view
    }()

    private let priceLabelPlaceholder: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 4
        view.isSkeletonable = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        self.isSkeletonable = true
        contentView.isSkeletonable = true
        separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(productImageViewPlaceholder)
        contentView.addSubview(titleLabelPlaceholder)
        contentView.addSubview(descriptionLabelPlaceholder)
        contentView.addSubview(priceLabelPlaceholder)

        productImageViewPlaceholder.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(120)
        }

        titleLabelPlaceholder.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(productImageViewPlaceholder.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }

        descriptionLabelPlaceholder.snp.makeConstraints { make in
            make.top.equalTo(titleLabelPlaceholder.snp.bottom).offset(4)
            make.leading.trailing.equalTo(titleLabelPlaceholder)
            make.height.equalTo(60)
        }

        priceLabelPlaceholder.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabelPlaceholder.snp.bottom).offset(12)
            make.leading.equalTo(titleLabelPlaceholder)
            make.bottom.equalToSuperview().inset(16)
            make.width.equalTo(60)
            make.height.equalTo(24)
        }
    }

    func showShimmer() {
        self.showAnimatedGradientSkeleton()
    }

    func hideShimmer() {
        self.hideSkeleton()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hideShimmer()
    }
} 
