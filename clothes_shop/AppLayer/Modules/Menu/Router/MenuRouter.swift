//
//  MenuRouter.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-05-05.
//

import UIKit

protocol MenuRouterProtocol {
    func openSubcategory(_ sub: Subcategory, from view: UIViewController)
}

class MenuRouter: MenuRouterProtocol {
    func openSubcategory(_ sub: Subcategory, from view: UIViewController) {
        // view.navigationController?.pushViewController(vc, animated: true)
    }
}
