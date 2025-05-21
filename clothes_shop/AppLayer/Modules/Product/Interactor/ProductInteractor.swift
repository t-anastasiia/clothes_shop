//
//  ProductInteractor.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-18.
//

import Foundation

final class ProductInteractor: ProductInteractorProtocol {
    weak var output: ProductInteractorOutputProtocol?
    private let product: Product

    init(product: Product) {
        self.product = product
    }

    func fetchProduct() {
        output?.didFetchProduct(product)
    }
}
