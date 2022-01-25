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
    var posterPath: String?
    var backdropPath: String?
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
    
}




