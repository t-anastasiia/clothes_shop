//
//  ProductRepository.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-17.
//

import Foundation

protocol ProductRepositoryProtocol {
    func fetchAll() async throws -> [Product]
    func fetchDetails(id: Int) async throws -> Product
}

final class ProductRepository: ProductRepositoryProtocol {
    private let networkService: NetworkService

    init(networkService: NetworkService = .shared) {
        self.networkService = networkService
    }

    func fetchAll() async throws -> [Product] {
        let req = ProductRequest(endpoint: .list)
        let dtos: [ProductDTO] = try await networkService.request(req)
        return dtos.map { $0.toDomain() }
    }

    func fetchDetails(id: Int) async throws -> Product {
        let req = ProductRequest(endpoint: .details(id: id))
        let dto: ProductDTO = try await networkService.request(req)
        return dto.toDomain()
    }
}
