//
//  MainConfigurator.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-05.
//

import UIKit

final class MainConfigurator {
    
    func configure() -> UIViewController {
        let menuVC = MenuConfigurator.configure()
        let navMenuVC = UINavigationController(rootViewController: menuVC)
//        let cartVC = CartConfigurator.configure()
//        let profileVC = ProfileConfigurator.configure()

        let viewController = MainViewController(menuModule: navMenuVC)

        return viewController
    }
}
