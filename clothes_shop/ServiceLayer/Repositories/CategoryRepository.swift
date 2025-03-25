//
//  CategoryRepository.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-19.
//

import Foundation

protocol CategoryRepositoryProtocol {
    func getGenderCategories() -> [Category]
}

final class CategoryRepository: CategoryRepositoryProtocol {
    private let networkService: NetworkService
    
    init (networkService: NetworkService = .shared) {
        self.networkService = networkService
    }
    
    func getGenderCategories() -> [Category] {
        
    }
}
