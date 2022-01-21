//
//  AddMovieToFavourites.swift
//  Movies App
//
//  Created by aleksandre on 20.01.22.
//

import Foundation

protocol FavouriteMoviesDelegate: AnyObject {
    
    func addMovie(_ movie: Movie)
}
