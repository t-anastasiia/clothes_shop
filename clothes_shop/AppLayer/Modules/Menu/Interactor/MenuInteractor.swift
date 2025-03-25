//
//  MenuInteractor.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-19.
//

import Foundation

final class MenuInteractor: MenuInteractorProtocol {
    
    weak var presenter: MenuInteractorOutputProtocol?
    let repository: ProductRepositoryProtocol
    
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchProducts() {
        Task {
            do {
                // TODO: тут не detiled брать а фэтчить
                let product = try await repository.getProductDetails(productId: "207108727")
                await MainActor.run {
                    presenter?.didFetchProducts(products)
                }
            } catch {
                print("Error fetching product: \(error)")
            }
        }
    }
}
