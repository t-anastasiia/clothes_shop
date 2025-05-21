//
//  NetworkConfig.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-17.
//

import Foundation

struct NetworkConfig {
    static var baseURL: String {
        guard let url = Bundle.main.infoDictionary?["API_BASE_URL"] as? String else {
            fatalError("Base URL not found in configuration")
        }
        return url
    }

    static var timeoutInterval: TimeInterval {
        guard let timeout = Bundle.main.infoDictionary?["API_TIMEOUT_INTERVAL"] as? String,
              let timeoutInterval = TimeInterval(timeout) else {
            return 10.0
        }
        return timeoutInterval
    }

    static var defaultHeaders: [String: String] {
        return [:] 
    }
}
