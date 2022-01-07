//
//  Endpoint.swift
//  Movies App
//
//  Created by aleksandre on 26.12.21.
//

import Foundation

protocol Endpoint {
    
    var scheme: String { get }
    
    var baseURL: String { get }
    
    var path: String { get }
    
    var parameters: [URLQueryItem] { get }
    
    var method: String { get }
    
}
