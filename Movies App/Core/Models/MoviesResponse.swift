//
//  UpcomingMoviesResponse.swift
//  Movies App
//
//  Created by aleksandre on 10.01.22.
//

import Foundation

struct MoviesResponse: Codable {
    
    let results: [Movie]
    let page: Int
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case page
        case totalPages = "total_pages"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try container.decode([Movie].self, forKey: .results)
        self.page = try container.decode(Int.self, forKey: .page)
        self.totalPages = try container.decode(Int.self, forKey: .totalPages)
    }
}
