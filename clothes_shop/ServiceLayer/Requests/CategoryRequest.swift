//
//  CategoryRequest.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-19.
//

import Foundation

enum CategoryEndpoint {
    case byGender(_ gender: Gender)
    
    var path: String {
        switch self {
            case .byGender(let gender):
                return "/marketplace/categories/\(gender)"
        }
    }
}

struct CategoryRequest: RequestProtocol {
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
