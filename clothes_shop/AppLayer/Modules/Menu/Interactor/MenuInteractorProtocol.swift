//
//  MenuInteractorProtocol.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-19.
//

import Foundation

protocol MenuInteractorProtocol: AnyObject {
    func fetchProducts()
}

protocol MenuInteractorInputProtocol: AnyObject {
    func fetchProducts()
}

protocol MenuInteractorOutputProtocol: AnyObject {
    func didFetchProducts(_ products: [Product])
}
