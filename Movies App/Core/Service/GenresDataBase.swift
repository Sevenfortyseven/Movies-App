//
//  GenresDataBase.swift
//  Movies App
//
//  Created by aleksandre on 09.01.22.
//

import Foundation

struct GenresDataBase {
    
    private static var data = [Int: String]()
    
    public static func setGenreData(_ genreID: Int, name: String) {
        data[genreID] = name
    }
    
    public static func getGenreData(_ genreID: [Int?]) -> String? {
        // Transforms an array of strings into one string
        var genreIdArray = [String]()
        var genreNamesCombined: String
        
        
        for id in genreID {
            
            guard id != nil else {
                print("error while appending genre names with ID")
                return nil
            }
            
            genreIdArray.append(data[id!]!)
        }
        genreNamesCombined = genreIdArray.joined(separator: ",")
        return genreNamesCombined
    }
}
