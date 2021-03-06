//
//  MoviesDbEndpoint.swift
//  Movies App
//
//  Created by aleksandre on 26.12.21.
//

import Foundation

enum MoviesDbEndpoint: Endpoint {
    
    case dailyTrends
    case WeeklyTrends
    case moviesGenres
    case comingSoon
    case topRated
    case search(query: String)
    case movieTrailer(movieID: Int)
    case userReviews(movieID: Int)
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return "api.themoviedb.org"
        }
    }
    
    var path: String {
        switch self {
        case .dailyTrends: return "/3/trending/movie/day"
        case .WeeklyTrends: return "/3/trending/movie/week"
        case .moviesGenres: return "/3/genre/movie/list"
        case .comingSoon: return "/3/movie/upcoming"
        case .topRated: return "/3/movie/top_rated"
        case .search: return "/3/search/movie"
        case .movieTrailer(let movieID): return "/3/movie/\(movieID)/videos"
        case .userReviews(let movieID): return "/3/movie/\(movieID)/reviews"
        }
    }
    
    
    var parameters: [URLQueryItem] {
        let API_KEY = "08c2f604eb89c1dd78a4e0a744575c02"

        
        switch self {
        case .comingSoon: return [URLQueryItem(name: "api_key", value: API_KEY),
                                  URLQueryItem(name: "page", value: "1")
        ]
        case .topRated: return [URLQueryItem(name: "api_key", value: API_KEY),
                                URLQueryItem(name: "page", value: "15")
        ]
        case .search(let query): return [URLQueryItem(name: "api_key", value: API_KEY),
                              URLQueryItem(name: "page", value: "1"),
                              URLQueryItem(name: "query", value: query)
        ]
        default: return [URLQueryItem(name: "api_key", value: API_KEY)]
        }
        
    }
    
    
    var method: String {
        switch self {
        case .WeeklyTrends: return "GET"
        case .dailyTrends: return "GET"
        case .moviesGenres: return "GET"
        case .comingSoon: return "GET"
        case .topRated: return "GET"
        case .search: return "GET"
        case .movieTrailer: return "GET"
        case .userReviews: return "GET"
        }
    }
    
    
}
