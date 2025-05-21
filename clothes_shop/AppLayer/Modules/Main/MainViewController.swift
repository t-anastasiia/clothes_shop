//
//  MainViewController.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-05.
//

import UIKit

final class MainViewController: UITabBarController {
    
    private let menuVC: UINavigationController
    private let cartVC = CartViewController()
    private let profileVC = ProfileViewController()

    init(menuModule: UINavigationController) {
        self.menuVC = menuModule
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use init(menuModule:)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupTabBar()
    }
    
    private func setupViewControllers() {
        menuVC.tabBarItem = UITabBarItem(title: "Меню", image: UIImage(systemName: "list.bullet"), tag: 0)
        cartVC.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(systemName: "cart"), tag: 1)
        profileVC.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), tag: 2)
        
        viewControllers = [menuVC, cartVC, profileVC]
    }
    
    private func setupTabBar() {
        tabBar.tintColor = UIColor(named: "BrownLight")
        tabBar.unselectedItemTintColor = UIColor(named: "Text/Second")
        tabBar.backgroundColor = .white
    }
}
