//
//  MainConfigurator.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-05.
//

import UIKit

final class MainConfigurator {

    func configure() -> UIViewController {

        // TODO: вернуть на MainViewController
        /// сейчас тут ProductViewController чтобы тестировать его для ДЗ1
        
        let viewController = ProductRouter.createModule()
        return viewController
    }
}
