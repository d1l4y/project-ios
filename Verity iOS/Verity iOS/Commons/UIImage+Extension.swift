//
//  UIImage+Extension.swift
//  Verity iOS
//
//  Created by Vinicius Augusto Dilay de Paula on 24/08/23.
//

import UIKit

extension UIImage {
    static func getImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        guard let imageURL = URL(string: url) else {
            completion(nil)
            return
        }
        let imageRequest = URLRequest(url: imageURL)
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: imageRequest),
           let cachedImage = UIImage(data: cachedResponse.data) {
            completion(cachedImage)
            return
        }
        
        URLSession.shared.dataTask(with: imageRequest) { data, response, error in
            if let data = data, let response = response, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
                
                let cachedResponse = CachedURLResponse(response: response, data: data)
                URLCache.shared.storeCachedResponse(cachedResponse, for: imageRequest)
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}
