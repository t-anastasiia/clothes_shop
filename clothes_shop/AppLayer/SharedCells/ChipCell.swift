    //
    //  ChipCell.swift
    //  clothes_shop
    //
    //  Created by anastasiia talmazan on 2025-04-08.
    //

    import UIKit
    import SnapKit

    class ChipCell: UICollectionViewCell {
        static let identifier = "ChipCell"

        private let titleLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14, weight: .medium)
            label.textAlignment = .center
            label.textColor = .black
            return label
        }()

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }

        private func setupUI() {
            contentView.addSubview(titleLabel)
            contentView.layer.cornerRadius = 16

            titleLabel.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }

            titleLabel.textAlignment = .center
            titleLabel.numberOfLines = 1
            titleLabel.lineBreakMode = .byTruncatingTail
        }

        func configure(text: String, isSelected: Bool) {
            titleLabel.text = text
            contentView.backgroundColor = isSelected ? UIColor(named: "BrownDark") : UIColor(named: "LightGray")
            titleLabel.textColor = isSelected ? UIColor(named: "Text/White") : UIColor(named: "Text/Primary")
        }
    }
