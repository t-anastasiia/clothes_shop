//
//  MainTabBarView.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-05.
//

import UIKit

protocol MainTabBarViewDelegate: AnyObject {
    func didTapMenuIcon()
    func didTapCartIcon()
    func didTapProfileIcon()
}

class MainTabBarView: UIView {
    
    weak var delegate: MainTabBarViewDelegate?
    
    // MARK: - Subviews
    
    private let menuButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bag"), for: .normal)
        button.setTitle("Меню", for: .normal)
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    private let cartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "basket"), for: .normal)
        button.setTitle("Корзина", for: .normal)
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    private let profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "person"), for: .normal)
        button.setTitle("Профиль", for: .normal)
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupActions()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupActions()
        setupConstraints()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        backgroundColor = .white
        
        stackView.addArrangedSubview(menuButton)
        stackView.addArrangedSubview(cartButton)
        stackView.addArrangedSubview(profileButton)
        
        addSubview(stackView)
        
        layer.shadowColor = UIColor(red: 130/255, green: 136/255, blue: 142/255, alpha: 0.25).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: -2)
        layer.shadowRadius = 15
        
    }
    
    private func setupActions() {
        menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        cartButton.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(10)
            make.top.equalToSuperview().inset(10)
        }
    }
    
    // MARK: - Actions
    
    @objc private func menuButtonTapped() {
        delegate?.didTapMenuIcon()
    }
    
    @objc private func cartButtonTapped() {
        delegate?.didTapCartIcon()
    }
    
    @objc private func profileButtonTapped() {
        delegate?.didTapProfileIcon()
    }
}
