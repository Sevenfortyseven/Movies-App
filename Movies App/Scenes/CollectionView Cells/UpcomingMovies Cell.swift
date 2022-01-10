//
//  TopRatedMovies Cell.swift
//  Movies App
//
//  Created by aleksandre on 10.01.22.
//

import Foundation
import UIKit

class UpcomingMoviesCollectionViewCell: UICollectionViewCell {
    
    private(set) static var identifier = "TopRatedMoviesCollectionViewCell"
    
    // MARK: - Instances
    
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        _ = self.roundedCorners
        addSubviews()
        initializeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUI()
    }
    
    // Populate contentView with subViews
    private func addSubviews() {
        self.contentView.addSubview(moviePoster)
    }
    
    // Initialize cell content
    public func initializeCellContent(_ movie: Movie) {
        self.moviePoster.loadImageFromUrl(urlString: StaticEndpoint.remoteImagesEndpoint + movie.posterPath)
    }
    
    // MARK: - ContentView
    private let moviePoster: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    
    // MARK: - UI update
    
    private func updateUI() {
        moviePoster.frame = self.contentView.bounds
    }
    
    // MARK: - Constraints
    
    private func initializeConstraints() {
        let constraints = [NSLayoutConstraint]()
        
        NSLayoutConstraint.activate(constraints)
        
    }
}
