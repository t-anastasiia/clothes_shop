//
//  RequestBuilder.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-17.
//

/// Этот файл отвечает за создание HTTP-запросов на основе параметров

import Foundation

protocol RequestBuilderProtocol {
    func build(_ request: RequestProtocol) throws -> URLRequest
}

final class RequestBuilder: RequestBuilderProtocol {
    func build(_ request: RequestProtocol) throws -> URLRequest {
        guard var urlComponents = URLComponents(string: NetworkConfig.baseURL + request.path) else {
            throw NetworkError.invalidURL
        }

        if !request.queryParameters.isEmpty {
            urlComponents.queryItems = request.queryParameters.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }

        guard let finalURL = urlComponents.url else {
            throw NetworkError.invalidURL
        }

        var urlRequest = URLRequest(url: finalURL)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpBody = request.body
        urlRequest.timeoutInterval = NetworkConfig.timeoutInterval
        
        print("Final request URL:", finalURL.absoluteString) 
        return urlRequest
    }
}
