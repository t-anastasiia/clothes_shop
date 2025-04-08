//
//  ProductInteractor.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-18.
//

import Foundation

final class ProductInteractor: ProductInteractorProtocol {
    
    weak var presenter: ProductInteractorOutputProtocol?
    let repository: ProductRepositoryProtocol
    
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchProduct() {
        Task {
            do {
                let product = try await repository.getProductDetails(productId: "207108727")
                await MainActor.run {
                    presenter?.didFetchProduct(product)
                }
            } catch {
                print("Error fetching product: \(error)")
            }
        }
    }
}
