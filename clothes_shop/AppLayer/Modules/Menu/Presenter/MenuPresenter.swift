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

    private let options: [CategoryEndpoint] = [.men, .women]

    init(interactor: MenuInteractorInput, router: MenuRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }

    func didLoadView() {
        view?.showLoading()
        interactor.fetchCategories(for: options[0])
    }

    func didSelectSegment(index: Int) {
        view?.showLoading()
        interactor.fetchCategories(for: options[index])
    }
}

extension MenuPresenter: MenuInteractorOutput {
    func didFetch(categories: [Category]) {
        view?.show(categories: categories)
    }
    func didFail(error: Error) {
        view?.show(error: error.localizedDescription)
    }
}
