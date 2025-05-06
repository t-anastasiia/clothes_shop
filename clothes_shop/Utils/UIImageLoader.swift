//
//  UIImageLoader.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-04-08.
//

import UIKit

final class UIImageLoader {
    func loadImage(from url: URL?, placeholder: UIImage? = UIImage(systemName: "photo"), completion: @escaping (UIImage?) -> Void) {
        guard let url = url else {
            completion(placeholder)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil) 
            }
        }.resume()
    }
}
