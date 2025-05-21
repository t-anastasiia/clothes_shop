//
//  ProductPresenter.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-18.
//

import UIKit

class ProductPresenter: ProductPresenterProtocol {
    private weak var view: ProductViewProtocol?
    private let repository: ProductRepositoryProtocol
    private var currentProduct: Product?
    private var allProducts: [Product] = []
    private let router: ProductRouterProtocol

    init(
        view: ProductViewProtocol,
        repository: ProductRepositoryProtocol,
        initialProduct: Product,
        router: ProductRouterProtocol
    ) {
        self.view = view
        self.repository = repository
        self.currentProduct = initialProduct
        self.router = router
    }

    func viewDidLoad() {
        Task {
            do {
                self.allProducts = try await repository.fetchAll()
            } catch {
                print("Ошибка загрузки всех товаров: \(error)")
            }
        }
    }

    func loadRecommendations(for product: Product) {
        Task {
            do {
                if self.allProducts.isEmpty {
                    self.allProducts = try await repository.fetchAll()
                }
                getSimpleRecommendations(for: product)
            } catch {
                print("Ошибка загрузки рекомендаций: \(error)")
            }
        }
    }

    private func getSimpleRecommendations(for product: Product) {
        let filtered = allProducts.filter { $0.category == product.category && $0.id != product.id }
        let recommendations = Array(filtered.prefix(3))
        DispatchQueue.main.async {
            self.view?.displayRecommendedProducts(recommendations)
        }
    }

    func didSelectRecommendedProduct(_ product: Product) {
        router.showProductDetails(for: product, from: (view as? UIViewController)?.navigationController)
    }
}

extension ProductPresenter: ProductInteractorOutputProtocol {
    func didFetchProduct(_ product: Product) {
        view?.displayProduct(product)
    }
}
