//
//  CartViewController.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-05.
//

import UIKit
import SnapKit

class CartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        //TODO: cделать с учетом dark/ligt mode
        view.backgroundColor = .white
    }
    
    private lazy var navTitleLable: UILabel = {
        let label = UILabel()
        label.text = "Корзина"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "trash")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = UIColor(named: "Button/Gray") //TODO: cделать с учетом dark/ligt mode
//        button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        return button
    }()

    private func setupNavigationBar() {
        let customNavBar = UIView()
        customNavBar.backgroundColor = .white //TODO: cделать с учетом dark/ligt mode
        customNavBar.layer.shadowColor = UIColor(red: 0x82/255, green: 0x88/255, blue: 0x8E/255, alpha: 0.25).cgColor
        customNavBar.layer.shadowOpacity = 1
        customNavBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        customNavBar.layer.shadowRadius = 15
        
        view.addSubview(customNavBar)
        
        customNavBar.addSubview(navTitleLable)
        customNavBar.addSubview(clearButton)
        
        navTitleLable.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.bottom.equalToSuperview().inset(9)
            make.centerX.equalToSuperview()
        }
        
        clearButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(12)
            make.size.equalTo(24)
        }
        
        customNavBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
    }
    
}
