//
//  CategoryRequest.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-05-05.
//

import Foundation

enum CategoryEndpoint {
    case list
    case byCategory(_ category: String)

    var path: String {
        switch self {
            case .list:
                return "/products/categories"
            case .byCategory(let category):
                return "/products/category/\(category)"
        }
    }
    var queryParameters: [String:String] { [:] }
}

struct CategoryRequest: RequestProtocol {
    let endpoint: CategoryEndpoint
    var path: String { endpoint.path }
    var method: HTTPMethod { .get }
    var headers: [String:String] { NetworkConfig.defaultHeaders }
    var queryParameters: [String:String] { endpoint.queryParameters }
    var body: Data? { nil }
}
