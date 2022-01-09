//
//  GenresDataBase.swift
//  Movies App
//
//  Created by aleksandre on 09.01.22.
//

import Foundation

struct GenresDataBase {
    
    private static var data = [Int: String]()
    
    public static func setGenreData(_ id: Int, name: String) {
        data[id] = name
    }
    
    public static func getGenreData(_ id: [Int]) -> String {
        // Transforms an array of strings into one string
        var genreIdArray = [String]()
        var genreNamesCombined: String
        
        for item in id {
            genreIdArray.append(data[item]!)
        }
        genreNamesCombined = genreIdArray.joined(separator: ",")
        return genreNamesCombined
    }
}
