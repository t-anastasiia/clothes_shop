//
//  CategoryRequest.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-05-05.
//

import Foundation

enum CategoryEndpoint {
    case men, women

    var path: String {
        switch self {
            case .men:   return "/marketplace/categories/men"
            case .women: return "/marketplace/categories/women"
        }
    }
}

struct CategoryRequest: RequestProtocol {
    let endpoint: CategoryEndpoint
    var path: String { endpoint.path }
    var method: HTTPMethod { .get }
    var headers: [String: String] { NetworkConfig.defaultHeaders }
    var queryParameters: [String: String] { [:] }
    var body: Data? { nil }

    init(endpoint: CategoryEndpoint) {
        self.endpoint = endpoint
    }
}
