//
//  GenresDataBase.swift
//  Movies App
//
//  Created by aleksandre on 09.01.22.
//

import Foundation

struct GenresDataBase {
    
    private static var genreData = [Int: String]()
    
    public static func setGenreData(_ genreID: Int, name: String) {
        genreData[genreID] = name
    }
    
    public static func getGenreData(_ genreID: [Int]) -> String {
        // Transforms an array of strings into one string
        var genreIdArray = [String]()
        var genreNamesCombined: String

        for id in genreID {
            let data = genreData[id]
            guard  data != nil else { break }
            genreIdArray.append(data!)
            
        }
        
        genreNamesCombined = genreIdArray.joined(separator: ",")
        return genreNamesCombined
    }
}
