//
//  CategoryRepository.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-05-05.
//

import Foundation

protocol CategoryRepositoryProtocol {
    func getCategories(for endpoint: CategoryEndpoint) async throws -> [Category]
    func fetchByCategorySlug(_ slug: String) async throws -> [Product]
}

final class CategoryRepository: CategoryRepositoryProtocol {
    private let networkService: NetworkService

    init(networkService: NetworkService = .shared) {
        self.networkService = networkService
    }

    func getCategories(for endpoint: CategoryEndpoint) async throws -> [Category] {
        let request = CategoryRequest(endpoint: endpoint)
        let names: [String] = try await networkService.request(request)
        return names.map { Category(name: $0) }
    }

    func fetchByCategorySlug(_ slug: String) async throws -> [Product] {
        let req = CategoryRequest(endpoint: .byCategory(slug))
        let dtos: [ProductDTO] = try await networkService.request(req)
        return dtos.map { $0.toDomain() }
    }
}
