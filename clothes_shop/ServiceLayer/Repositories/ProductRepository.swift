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
    private let cacheService: CacheService

    init(networkService: NetworkService = .shared, cacheService: CacheService = .shared) {
        self.networkService = networkService
        self.cacheService = cacheService
    }

    func fetchAll() async throws -> [Product] {
        let cacheKey = "products_all"
        
        // Проверяем кэш
        if let cachedData = cacheService.getData(forKey: cacheKey),
           let dtos = try? JSONDecoder().decode([ProductDTO].self, from: cachedData) {
            return dtos.map { $0.toDomain() }
        }
        
        let req = ProductRequest(endpoint: .list)
        let dtos: [ProductDTO] = try await networkService.request(req)
        
        // Сохраняем в кэш
        if let data = try? JSONEncoder().encode(dtos) {
            cacheService.setData(data, forKey: cacheKey)
        }
        
        return dtos.map { $0.toDomain() }
    }

    func fetchDetails(id: Int) async throws -> Product {
        let cacheKey = "product_details_\(id)"
        
        // Проверяем кэш
        if let cachedData = cacheService.getData(forKey: cacheKey),
           let dto = try? JSONDecoder().decode(ProductDTO.self, from: cachedData) {
            return dto.toDomain()
        }
        
        let req = ProductRequest(endpoint: .details(id: id))
        let dto: ProductDTO = try await networkService.request(req)
        
        // Сохраняем в кэш
        if let data = try? JSONEncoder().encode(dto) {
            cacheService.setData(data, forKey: cacheKey)
        }
        
        return dto.toDomain()
    }
}
