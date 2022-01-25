//
//  VideosResponse.swift
//  Movies App
//
//  Created by aleksandre on 19.01.22.
//

import Foundation

struct VideosResponse: Codable {
    
    let results: [Video]
    let id: Int
    
    enum CodingKeys: Codable, CodingKey {
        
        case results
        case id
    }
}
