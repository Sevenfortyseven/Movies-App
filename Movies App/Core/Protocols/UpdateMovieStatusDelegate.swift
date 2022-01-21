//
//  UpdateMovieDelegate.swift
//  Movies App
//
//  Created by aleksandre on 21.01.22.
//

import Foundation

protocol UpdateMovieStatusDelegate {
    
    func updateStatus(movie: [Movie], isFavourite: Bool)
    
}
