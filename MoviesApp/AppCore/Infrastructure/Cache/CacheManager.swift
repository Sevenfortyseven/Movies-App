//
//  CacheManager.swift
//  Movies App
//
//  Created by aleksandre on 08.01.22.
//

import Foundation

class CacheManager {
    
    private static var cache  = [String: Data]()
    
    public static func setImageCache(_ url: String, _ data: Data?) {
        // Store image data and use url as the key
        cache[url] = data
    }
    
    public static func getImageCache(_ url: String) -> Data? {
        // Try to get data from the specified url
        return cache[url]
    }
}
