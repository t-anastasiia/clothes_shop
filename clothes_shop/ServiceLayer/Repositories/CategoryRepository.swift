//
//  CategoryRepository.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-05-05.
//

import Foundation

protocol CategoryRepositoryProtocol {
    func getCategories(for endpoint: CategoryEndpoint) async throws -> [Category]
}

final class CategoryRepository: CategoryRepositoryProtocol {
    private let networkService: NetworkService

    init(networkService: NetworkService = .shared) {
        self.networkService = networkService
    }

    func getCategories(for endpoint: CategoryEndpoint) async throws -> [Category] {
        let request = CategoryRequest(endpoint: endpoint)
        let dto: CategoriesResponseDTO = try await networkService.request(request)
        return dto.data.categories.map { $0.toDomain() }
    }
}
