//
//  NetworkService.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-17.
//

import Foundation

final class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()
    private let session: URLSession
    
    private init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ request: RequestProtocol) async throws -> T {
        guard var urlComponents = URLComponents(string: NetworkConfig.baseURL + request.path) else {
            throw NetworkError.invalidURL
        }
        
        if !request.queryParameters.isEmpty {
            urlComponents.queryItems = request.queryParameters.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }
        
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.timeoutInterval = NetworkConfig.timeoutInterval
        urlRequest.cachePolicy = .useProtocolCachePolicy
        
        do {
            print("Final request URL:", urlRequest.url?.absoluteString ?? "Invalid URL")
            let (data, response) = try await session.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.serverError("Invalid response type")
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                let decoder = JSONDecoder()
                return try decoder.decode(T.self, from: data)
            case 401:
                throw NetworkError.unauthorized
            case 404:
                throw NetworkError.notFound
            default:
                throw NetworkError.serverError("Status code: \(httpResponse.statusCode)")
            }
        } catch {
            throw error
        }
    }
}
