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
        let configurator = ProductConfigurator()
        let productVC = configurator.configure(with: product)
        navigationController.pushViewController(productVC, animated: true)
    }
}
