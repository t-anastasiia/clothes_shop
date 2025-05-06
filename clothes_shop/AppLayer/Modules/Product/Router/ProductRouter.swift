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
        let interactor = ProductInteractor(product: product)
        let router = ProductRouter()
        let presenter = ProductPresenter(view: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}
