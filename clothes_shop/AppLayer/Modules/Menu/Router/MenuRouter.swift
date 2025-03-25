//
//  MenuRouter.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-19.
//

import UIKit

final class MenuRouter {
    
    static func createModule() -> UIViewController {
        let view = MenuViewController()
        let repository = ProductRepository()
        let interactor = MenuInteractor(repository: repository)
        let router = MenuRouter()
        let presenter = MenuPresenter()
    }
}
