//
//  ProductDTO+Mapper.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-04-08.
//

import Foundation

extension ProductDTO {
    func toDetailed() -> ProductDetailed {
        let sizes = variants.map {
            SizeDetailed(
                id: $0.id,
                brandSize: $0.brandSize,
                displayText: $0.displaySizeText,
                isAvailable: $0.isAvailable
            )
        }.sorted { $0.brandSize < $1.brandSize }

        let imageUrl = images.first(where: { $0.isPrimary })?.url
        let fullUrl = imageUrl?.hasPrefix("http") == true ? imageUrl : (imageUrl.map { "https://\($0)" })

        return ProductDetailed(
            id: productId,
            name: name,
            description: description,
            price: price.current.text,
            imageUrl: fullUrl,
            sizes: sizes,
            isInStock: isInStock,
            isAvailable: isAvailable
        )
    }
}
