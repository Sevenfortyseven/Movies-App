//
//  FavouriteMovies Cell.swift
//  Movies App
//
//  Created by aleksandre on 20.01.22.
//

import Foundation
import UIKit

class FavouriteMoviesCollectionViewCell: UICollectionViewCell {

    private(set) static var identifier = "FavouriteMoviesCollectionViewCell"
    
    
    //MARK: - Instances
    
    private(set) var movie: Movie?

    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        updateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateFrames()
    }
    
    //Add subviews
    private func addSubviews() {
        self.contentView.addSubview(moviePosterView)

    }
    
    public func initializeContentView(_ movie: Movie) {
        guard let posterURL = movie.posterPath else {
            print("Poster url not available")
            return
        }
        let url = StaticEndpoint.remoteImagesEndpoint + posterURL
        self.moviePosterView.loadImageFromUrl(urlString: url)
        self.movie = movie
        
    }
    
    //MARK: - UI configuration
    private func updateUI() {
        moviePosterView.frame = self.contentView.bounds
        
    }
    
    private func updateFrames() {
        _ = self.roundedCornersMaxCurve
        self.clipsToBounds = true
        
    }
    
    
    //MARK: - UI Elements
    
    private let moviePosterView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = true
        imageView.clipsToBounds = true
        return imageView
    }()

}
