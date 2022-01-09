//
//  Movie.swift
//  Movies App
//
//  Created by aleksandre on 27.12.21.


import Foundation

struct Movie: Codable {
    
    var overview: String
    var releaseDate: String
    var voteCount: Int
    var language: String
    var movieId: Int
    var title: String
    var averageVote: Double
    var popularity: Double
    var posterPath: String
    var backdropPath: String
    var genreIDs: [Int]
    
    enum CodingKeys: String, CodingKey {
        case overview
        case releaseDate = "release_date"
        case voteCount = "vote_count"
        case language = "original_language"
        case movieId = "id"
        case title = "original_title"
        case averageVote = "vote_average"
        case popularity
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genreIDs = "genre_ids"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.voteCount = try container.decode(Int.self, forKey: .voteCount)
        self.language = try container.decode(String.self, forKey: .language)
        self.movieId = try container.decode(Int.self, forKey: .movieId)
        self.title = try container.decode(String.self, forKey: .title)
        self.averageVote = try container.decode(Double.self, forKey: .averageVote)
        self.popularity = try container.decode(Double.self, forKey: .popularity)
        self.posterPath = try container.decode(String.self, forKey: .posterPath)
        self.backdropPath = try container.decode(String.self, forKey: .backdropPath)
        self.genreIDs = try container.decode([Int].self, forKey: .genreIDs)
    }
}

