//
//  ProductPresenterProtocol.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-18.
//

import Foundation

protocol ProductPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSelectRecommendedProduct(_ product: Product)
    func loadRecommendations(for product: Product)
}

