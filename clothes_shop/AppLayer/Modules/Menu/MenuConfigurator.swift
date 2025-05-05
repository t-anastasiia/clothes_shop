//
//  MenuConfigurator.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-05-05.
//

import UIKit

enum MenuConfigurator {
    static func configure() -> UIViewController {
        let view = MenuViewController()
        let interactor = MenuInteractor(repo: CategoryRepository())
        let router = MenuRouter()
        let presenter = MenuPresenter(interactor: interactor, router: router)

        view.presenter = presenter
        presenter.view = view
        interactor.output = presenter

        return view
    }
}
