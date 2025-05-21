//
//  ProductRouterProtocol.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-18.
//

import UIKit

protocol ProductRouterProtocol: AnyObject {
    static func createModule(with product: Product) -> UIViewController
    func showProductDetails(for product: Product, from navigationController: UINavigationController?)
}
