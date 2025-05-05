//
//  MenuInteractor.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-05-05.
//

import Foundation

final class MenuInteractor: MenuInteractorInput {
    weak var output: MenuInteractorOutput?
    private let repo: CategoryRepositoryProtocol
    
    init(repo: CategoryRepositoryProtocol) {
        self.repo = repo
    }
    
    func fetchCategories(for endpoint: CategoryEndpoint) {
        Task {
            do {
                let cats = try await repo.getCategories(for: endpoint)
                output?.didFetch(categories: cats)
            } catch {
                output?.didFail(error: error)
            }
        }
    }
}
