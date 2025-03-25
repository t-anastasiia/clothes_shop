//
//  ProductConfigurator.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-19.
//

import UIKit

final class ProductConfigurator {
    
    func configure() -> UIViewController {
        let viewController = ProductRouter.createModule()
        return viewController
    }
    
}
