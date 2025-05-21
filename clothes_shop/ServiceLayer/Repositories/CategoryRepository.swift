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
    private let cacheService: CacheService

    init(networkService: NetworkService = .shared, cacheService: CacheService = .shared) {
        self.networkService = networkService
        self.cacheService = cacheService
    }

    func getCategories(for endpoint: CategoryEndpoint) async throws -> [Category] {
        let cacheKey = "categories_\(endpoint.path)"
        
        // Проверяем кэш
        if let cachedData = cacheService.getData(forKey: cacheKey),
           let categories = try? JSONDecoder().decode([String].self, from: cachedData) {
            return categories.map { Category(name: $0) }
        }
        
        let request = CategoryRequest(endpoint: endpoint)
        let names: [String] = try await networkService.request(request)
        
        // Сохраняем в кэш
        if let data = try? JSONEncoder().encode(names) {
            cacheService.setData(data, forKey: cacheKey)
        }
        
        return names.map { Category(name: $0) }
    }

    func fetchByCategorySlug(_ slug: String) async throws -> [Product] {
        let cacheKey = "products_category_\(slug)"
        
        // Проверяем кэш
        if let cachedData = cacheService.getData(forKey: cacheKey),
           let dtos = try? JSONDecoder().decode([ProductDTO].self, from: cachedData) {
            return dtos.map { $0.toDomain() }
        }
        
        let req = CategoryRequest(endpoint: .byCategory(slug))
        let dtos: [ProductDTO] = try await networkService.request(req)
        
        // Сохраняем в кэш
        if let data = try? JSONEncoder().encode(dtos) {
            cacheService.setData(data, forKey: cacheKey)
        }
        
        return dtos.map { $0.toDomain() }
    }
}
