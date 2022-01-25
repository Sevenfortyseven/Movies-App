//
//  UserReviewsResponse.swift
//  Movies App
//
//  Created by aleksandre on 19.01.22.
//

import Foundation


struct UserReviewsResponse: Codable {
    
    let id: Int
    let page: Int
    let results: [UserReview]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
