//
//  Video.swift
//  Movies App
//
//  Created by aleksandre on 19.01.22.
//

import Foundation


struct Video: Codable {
    
    var name: String
    var key: String
    var site: String
    var type: String
    var id: String
    
    enum CodingKeys: Codable, CodingKey {
        case name
        case key
        case site
        case type
        case id
    }
    
}
