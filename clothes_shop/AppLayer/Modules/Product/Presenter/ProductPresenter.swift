//
//  ProductPresenter.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-18.
//

import Foundation

final class ProductPresenter: ProductPresenterProtocol {
    
    weak var view: ProductViewProtocol?
    var interactor: ProductInteractorProtocol
    var router: ProductRouterProtocol
    
    init(view: ProductViewProtocol, interactor: ProductInteractorProtocol, router: ProductRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        interactor.fetchProduct()
    }
}

extension ProductPresenter: ProductInteractorOutputProtocol {
    func didFetchProduct(_ product: ProductDetails) {
        view?.displayProduct(product)
    }
}
