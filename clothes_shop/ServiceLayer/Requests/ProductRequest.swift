//
//  ProductListRequest.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-17.
//

import Foundation

enum ProductEndpoint {
    case byCategory(categoryId: String)
    case details(productId: String)
    
    var path: String {
        switch self {
        case .byCategory:
            return "/marketplace/product/bycategory"
        case .details:
            return "/product/description"
        }
    }
}

struct ProductRequest: RequestProtocol {
    let endpoint: ProductEndpoint
    let queryParams: [String: String]
    
    var path: String { endpoint.path }
    var method: HTTPMethod { .get }
    var headers: [String: String] { NetworkConfig.defaultHeaders }
    var queryParameters: [String: String] { queryParams }
    var body: Data? { nil }
    
    init(endpoint: ProductEndpoint, queryParams: [String: String] = [:]) {
        self.endpoint = endpoint
        self.queryParams = queryParams
    }
}
