//
//  MenuViewProtocol.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-05-05.
//

import Foundation

protocol MenuViewProtocol: AnyObject {
    func showLoading()
    func show(categories: [Category])
    func show(error: String)
    func showProducts(_ products: [Product])
}
