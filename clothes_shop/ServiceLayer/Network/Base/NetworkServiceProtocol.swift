//
//  NetworkServiceProtocol.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-17.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable>(_ request: RequestProtocol) async throws -> T
}
