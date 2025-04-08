//
//  ProductInteractorProtocol.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-18.
//

import Foundation

protocol ProductInteractorProtocol: AnyObject {
    func fetchProduct()
}

protocol ProductInteractorInputProtocol: AnyObject {
    func fetchProduct()
}

protocol ProductInteractorOutputProtocol: AnyObject {
    func didFetchProduct(_ product: ProductDetails)
}
