//
//  MainViewController.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-05.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    /// опции таб бара
    private let menuVC = MenuViewController()
    private let cartVC = CartViewController()
    private let profileVC = ProfileViewController()
    
    /// текущая опция таб бара
    private var currentChild: UIViewController?
    
    /// таб бар
    private let mainTabBar = MainTabBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        setupTabBar()
        
        switchToChild(menuVC)
    }
    
    private func setupTabBar() {
        view.addSubview(mainTabBar)
        mainTabBar.delegate = self
        
        mainTabBar.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func switchToChild(_ vc: UIViewController) {
        // убираем текущий экран
        if let current = currentChild {
            current.willMove(toParent: nil)
            current.view.removeFromSuperview()
            current.removeFromParent()
        }
        
        // добаляем нового
        addChild(vc)
        view.addSubview(vc.view)
        
        // вставляем под таб бар, чтоб он не перекрывался
        view.bringSubviewToFront(mainTabBar)
        
        vc.view.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(mainTabBar.snp.top)
        }
        
        vc.didMove(toParent: self)
        
        currentChild = vc
    }
}

// MARK: - MainTabBarViewDelegate
extension MainViewController: MainTabBarViewDelegate {
    func didTapMenuIcon() {
        switchToChild(menuVC)
    }
    
    func didTapCartIcon() {
        switchToChild(cartVC)
    }
    
    func didTapProfileIcon() {
        switchToChild(profileVC)
    }
}
