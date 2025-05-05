//
//  ProductRepository.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-17.
//

import Foundation

//
//  ProductRepository.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-17.
//

import Foundation

protocol ProductRepositoryProtocol {
    //    func getProductsByCategory(categoryId: String) async throws -> [ProductDetailed]
    func getProductDetails(productId: String) async throws -> ProductDetailed
}

final class ProductRepository: ProductRepositoryProtocol {
    private let networkService: NetworkService

    init(networkService: NetworkService = .shared) {
        self.networkService = networkService
    }

    //    func getProductsByCategory(categoryId: String) async throws -> [ProductDetailed] {
    //        let queryParams = ["categoryId": categoryId]
    //        let request = ProductRequest(
    //            endpoint: .byCategory(categoryId: categoryId),
    //            queryParams: queryParams
    //        )
    //        let response: ProductListResponseDTO = try await networkService.request(request)
    //        return response.data.products.map { $0.toDetailed() }
    //    }

    func getProductDetails(productId: String) async throws -> ProductDetailed {
        let request = ProductRequest(
            endpoint: .details(productId: productId),
            queryParams: ["productId": productId]
        )
        let response: ProductDetailsResponseDTO = try await networkService.request(request)
        return response.data.toDetailed()
    }
}

struct ProductDetailsResponseDTO: Codable {
    let data: ProductDTO
    let message: String?
    let error: String?
}
