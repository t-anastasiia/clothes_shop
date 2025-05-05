//
//  CategoryDTOs.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-05-05.
//

import Foundation

struct CategoriesResponseDTO: Decodable {
    let data: CategoryListDTO
}
struct CategoryListDTO: Decodable {
    let categories: [CategoryDTO]
}
struct CategoryDTO: Decodable {
    let name: String
    let url: String?
    let subcategories: [SubcategoryDTO]
}
struct SubcategoryDTO: Decodable {
    let name: String
    let id: String
    let url: String
}

extension CategoryDTO {
    func toDomain() -> Category {
        Category(
            name: name,
            url: url,
            subcategories: subcategories.map { $0.toDomain() }
        )
    }
}
extension SubcategoryDTO {
    func toDomain() -> Subcategory {
        Subcategory(name: name, id: id, url: url)
    }
}
