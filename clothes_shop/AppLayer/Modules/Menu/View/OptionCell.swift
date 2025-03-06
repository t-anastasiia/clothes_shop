//
//  OptionCell.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-06.
//

import UIKit
import SnapKit

class OptionCell: UICollectionViewCell {
    
    static let identifier = "OptionCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
