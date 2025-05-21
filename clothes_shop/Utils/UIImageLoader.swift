//
//  UIImageLoader.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-04-08.
//

import UIKit
import SkeletonView

final class UIImageLoader {
    private let cache = NSCache<NSString, UIImage>()
    private let queue = DispatchQueue(label: "com.clothes_shop.imageLoader", qos: .utility)
    
    init() {
        cache.countLimit = 100 
    }
    
    func loadImage(into imageView: UIImageView, from url: URL?, placeholder: UIImage? = UIImage(systemName: "photo")) {
        imageView.isSkeletonable = true
        imageView.showAnimatedGradientSkeleton()

        guard let url = url else {
            DispatchQueue.main.async {
                imageView.image = placeholder
                imageView.hideSkeleton()
            }
            return
        }
        
        // Проверяем кэш
        if let cachedImage = cache.object(forKey: url.absoluteString as NSString) {
            DispatchQueue.main.async {
                imageView.image = cachedImage
                imageView.hideSkeleton()
            }
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    // Сохраняем в кэш
                    self.cache.setObject(image, forKey: url.absoluteString as NSString)
                    imageView.image = image
                } else {
                    imageView.image = placeholder
                }
                imageView.hideSkeleton()
            }
        }.resume()
    }

    func loadImage(from url: URL?, placeholder: UIImage? = UIImage(systemName: "photo"), completion: @escaping (UIImage?) -> Void) {
        guard let url = url else {
            completion(placeholder)
            return
        }
        
        // Проверяем кэш
        if let cachedImage = cache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            
            if let data = data, let image = UIImage(data: data) {
                // Сохраняем в кэш
                self.cache.setObject(image, forKey: url.absoluteString as NSString)
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    func clearCache() {
        queue.async {
            self.cache.removeAllObjects()
        }
    }
}
