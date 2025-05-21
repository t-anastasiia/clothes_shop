//
//  ProductRouter.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-18.
//

import UIKit

final class ProductRouter: ProductRouterProtocol {
    static func createModule(with product: Product) -> UIViewController {
        let view = ProductViewController()
        let repository = ProductRepository()
        let router = ProductRouter()
        let presenter = ProductPresenter(
            view: view,
            repository: repository,
            initialProduct: product,
            router: router
        )
        
        view.presenter = presenter
        view.product = product
        
        return view
    }
    
    func showProductDetails(for product: Product, from navigationController: UINavigationController?) {
        let productVC = ProductConfigurator().configure(with: product)
        productVC.hidesBottomBarWhenPushed = true
        NotificationCenter.default.post(name: .hideMainTabBar, object: nil)
        navigationController?.pushViewController(productVC, animated: true)
    }
}
