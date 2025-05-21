//
//  MenuPresenter.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-05-05.
//

import Foundation

final class MenuPresenter: MenuPresenterProtocol {
    weak var view: MenuViewProtocol?
    private var interactor: MenuInteractorInput
    private var router: MenuRouterProtocol

    init(interactor: MenuInteractorInput, router: MenuRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }

    func didLoadView() {
        view?.showLoading()
        interactor.fetchCategories()
    }

    func didSelectCategory(_ category: Category) {
        view?.showLoading()
        interactor.fetchProducts(for: category)
    }
}

extension MenuPresenter: MenuInteractorOutput {
    func didFetch(categories: [Category]) {
        view?.show(categories: categories)
    }
    func didFail(error: Error) {
        view?.show(error: error.localizedDescription)
    }
    func didFetchProducts(_ products: [Product]) {
        view?.showProducts(products)
    }
}
