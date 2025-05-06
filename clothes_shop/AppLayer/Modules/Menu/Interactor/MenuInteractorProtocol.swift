//
//  MenuInteractorProtocol.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-05-05.
//

import Foundation

protocol MenuInteractorInput {
    func fetchCategories()
    func fetchProducts(for category: Category)
}
protocol MenuInteractorOutput: AnyObject {
    func didFetch(categories: [Category])
    func didFail(error: Error)
    func didFetchProducts(_ products: [Product])
}
