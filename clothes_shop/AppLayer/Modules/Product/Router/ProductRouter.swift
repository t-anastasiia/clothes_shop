//
//  ProductRouter.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-18.
//

import UIKit

final class ProductRouter: ProductRouterProtocol {
    
    static func createModule() -> UIViewController {
        let view = ProductViewController()
        let repository = ProductRepository() 
        let interactor = ProductInteractor(repository: repository)
        let router = ProductRouter()
        let presenter = ProductPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
}
