//
//  CatalogEntities.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-05-05.
//

import Foundation

struct Category {
    let name: String
    let url: String?
    let subcategories: [Subcategory]
}
struct Subcategory {
    let name: String
    let id: String
    let url: String
}
