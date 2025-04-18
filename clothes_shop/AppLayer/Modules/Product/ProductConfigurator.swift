//
//  ProductConfigurator.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-04-08.
//

import UIKit

final class ProductConfigurator {

    func configure() -> UIViewController {

        let viewController = ProductRouter.createModule()
        return viewController
    }
}
