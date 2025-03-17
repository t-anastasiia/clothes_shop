//
//  NetworkConfig.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-17.
//

import Foundation

// сейчас использую открытый ASOS API, в будущем планиурю оттуда спарсить данные на сервер (в процессе написания), чтобы там непосредственно работать с ним
struct NetworkConfig {
    static var apiKey: String {
        guard let key = Bundle.main.infoDictionary?["RAPID_API_KEY"] as? String else {
            fatalError("API Key not found in configuration")
        }
        return key
    }
    
    static var apiHost: String {
        guard let host = Bundle.main.infoDictionary?["RAPID_API_HOST"] as? String else {
            fatalError("API Host not found in configuration")
        }
        return host
    }
    
    static var baseURL: String {
        guard let url = Bundle.main.infoDictionary?["API_BASE_URL"] as? String else {
            fatalError("Base URL not found in configuration")
        }
        return url
    }
    
    static var timeoutInterval: TimeInterval {
        guard let timeout = Bundle.main.infoDictionary?["API_TIMEOUT_INTERVAL"] as? String,
              let timeoutInterval = TimeInterval(timeout) else {
            return 10.0 // Значение по умолчанию
        }
        return timeoutInterval
    }
    
    static var defaultHeaders: [String: String] {
        return [
            "x-rapidapi-key": apiKey,
            "x-rapidapi-host": apiHost
        ]
    }
}
