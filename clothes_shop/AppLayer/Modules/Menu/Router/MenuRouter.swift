//
//  MenuRouter.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-05-05.
//

import UIKit

protocol MenuRouterProtocol {
    func openProductDetails(navigationController: UINavigationController, with product: Product)
}

class MenuRouter: MenuRouterProtocol {
    func openProductDetails(navigationController: UINavigationController, with product: Product) {
        let productVC = ProductConfigurator().configure(with: product)
        productVC.hidesBottomBarWhenPushed = true
        NotificationCenter.default.post(name: .hideMainTabBar, object: nil)
        navigationController.pushViewController(productVC, animated: true)
    }
}
