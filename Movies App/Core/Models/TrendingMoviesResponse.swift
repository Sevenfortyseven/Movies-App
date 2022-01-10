//
//  MoviesDbRequest.swift
//  Movies App
//
//  Created by aleksandre on 27.12.21.
//

import Foundation


struct TrendingMoviesResponse: Codable {

    let results: [Movie]

    enum CodingKeys: String, CodingKey {
        case results
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try container.decode([Movie].self, forKey: .results)
    }
}

