//
//  ProductRepository.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-17.
//

import Foundation

protocol ProductRepositoryProtocol {
    func getProductsByCategory(categoryId: String) async throws -> [Product]
    func getProductDetails(productId: String) async throws -> ProductDetails
}

final class ProductRepository: ProductRepositoryProtocol {
    private let networkService: NetworkService
    
    init(networkService: NetworkService = .shared) {
        self.networkService = networkService
    }
    
    func getProductsByCategory(categoryId: String) async throws -> [Product] {
        let queryParams = ["categoryId": categoryId]
        let request = ProductRequest(
            endpoint: .byCategory(categoryId: categoryId),
            queryParams: queryParams
        )
        let response: ProductResponse = try await networkService.request(request)
        return response.data.products
    }
    
    func getProductDetails(productId: String) async throws -> ProductDetails {
        let request = ProductRequest(
            endpoint: .details(productId: productId),
            queryParams: ["productId": productId]
        )
        let response: ProductDetailsResponse = try await networkService.request(request)
        return response.data
    }
}

struct ProductDetailsResponse: Codable {
    let data: ProductDetails
    let error: String?
}
