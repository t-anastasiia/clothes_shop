//
//  ProductDTOs.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-04-08.
//

import Foundation

struct ProductDTO: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: URL
}

extension ProductDTO {
    func toDomain() -> Product {
        Product(id: id,
                title: title,
                price: price,
                description: description,
                category: category,
                image: image)
    }
}
