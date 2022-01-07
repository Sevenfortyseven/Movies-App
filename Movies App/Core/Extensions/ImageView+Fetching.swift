//
//  ImageView+Fetching.swift
//  Movies App
//
//  Created by aleksandre on 08.01.22.
//

import UIKit

extension UIImageView {
    @discardableResult
    func loadImageFromUrl(urlString: String) -> URLSessionDataTask? {
        self.image = nil
        
        if let cachedImage = CacheManager.getImageCache(urlString) {
            self.image = UIImage(data: cachedImage)
            return nil
        }
        guard let url = URL(string: urlString) else { return nil }
        
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                if let data = data, let downloadedImage = UIImage(data: data) {
                    // Save data into the cache
                    CacheManager.setImageCache(url.absoluteString, data)
                    self.image = downloadedImage
                    
                }
            }
        }
        task.resume()
        return task
    }
}
