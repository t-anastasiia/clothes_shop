//
//  RequestProtocol.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-17.
//

import Foundation

protocol RequestProtocol {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var queryParameters: [String: String] { get }
    var body: Data? { get }
}

extension RequestProtocol {
    var timeoutInterval: TimeInterval { 10.0 }
    var cachePolicy: URLRequest.CachePolicy { .useProtocolCachePolicy }
}
