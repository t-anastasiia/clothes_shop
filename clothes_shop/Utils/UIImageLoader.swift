//
//  UIImageLoader.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-04-08.
//

import UIKit

final class UIImageLoader {
    func loadImage(from urlString: String?, placeholder: UIImage? = UIImage(systemName: "photo"), completion: @escaping (UIImage?) -> Void) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            completion(placeholder)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, let image = UIImage(data: data), error == nil else {
                completion(placeholder)
                return
            }
            completion(image)
        }.resume()
    }
}
