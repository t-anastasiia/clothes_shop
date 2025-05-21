//
//  CacheService.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-05-21.
//

import Foundation

final class CacheService {
    static let shared = CacheService()
    
    private let cache = NSCache<NSString, NSData>()
    private let queue = DispatchQueue(label: "com.clothes_shop.cache", qos: .utility)
    
    private init() {
        cache.countLimit = 100 
    }
    
    func setData(_ data: Data, forKey key: String) {
        queue.async {
            self.cache.setObject(data as NSData, forKey: key as NSString)
        }
    }
    
    func getData(forKey key: String) -> Data? {
        queue.sync {
            return cache.object(forKey: key as NSString) as Data?
        }
    }
    
    func removeData(forKey key: String) {
        queue.async {
            self.cache.removeObject(forKey: key as NSString)
        }
    }
    
    func clearCache() {
        queue.async {
            self.cache.removeAllObjects()
        }
    }
} 
