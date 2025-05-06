//
//  ProductListRequest.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-17.
//

import Foundation

enum ProductEndpoint {
    case list
    case details(id: Int)

    var path: String {
        switch self {
            case .list:
                return "/products"
            case .details(let id):
                return "/products/\(id)"
        }
    }

    var queryParameters: [String:String] {
        return [:]
    }
}

struct ProductRequest: RequestProtocol {
    let endpoint: ProductEndpoint
    var path: String { endpoint.path }
    var method: HTTPMethod { .get }
    var headers: [String:String] { NetworkConfig.defaultHeaders }
    var queryParameters: [String:String] { endpoint.queryParameters }
    var body: Data? { nil }

    init(endpoint: ProductEndpoint) {
        self.endpoint = endpoint
    }
}
