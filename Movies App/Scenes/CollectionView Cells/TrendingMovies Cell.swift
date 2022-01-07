//
//  TrendingMovies Cell.swift
//  Movies App
//
//  Created by aleksandre on 07.01.22.
//

import UIKit

class TrendingMoviesCollectionViewCell: UICollectionViewCell {
    
    private(set) static var identifier = "TrendingMoviesCollectionViewCell"
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUI()
    }
    
    // Populate View with subviews
    private func addSubviews() {
        self.contentView.addSubview(moviePoster)
    }
    
    // Initialize Cell content
    public func initializeCellContent(_ movie: Movie) {
        self.moviePoster.loadImageFromUrl(urlString: "https://image.tmdb.org/t/p/w500" + movie.backdropPath)
    }
    
    // MARK: - Cell ContentView
    
    private let moviePoster: UIImageView = {
        let moviePoster = UIImageView()
        moviePoster.contentMode = .scaleAspectFit
        return moviePoster
    }()
    
    // MARK: - Update UI
    
    private func updateUI() {
        moviePoster.frame = self.contentView.bounds
    }
    
    // MARK: Constraints
    
    private func initializeConstraints() {
        let constraints = [NSLayoutConstraint]()
        
        
        // Movie image
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
