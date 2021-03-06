//
//  TopRatedMovies Cell.swift
//  Movies App
//
//  Created by aleksandre on 10.01.22.
//

import Foundation
import UIKit

class UpcomingMoviesCollectionViewCell: UICollectionViewCell {
    
    private(set) static var identifier = "UpcomingMoviesCollectionViewCell"
    
    // MARK: - Instances
    
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        updateUI()
        addSubviews()
        initializeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
   
    }
    
    // Populate contentView with subViews
    private func addSubviews() {
        self.contentView.addSubview(moviePoster)
    }
    
    // Initialize cell content
    public func initializeCellContent(_ movie: Movie?) {
        guard let poster = movie?.posterPath else {
            print("Error while initializing content")
            return
        }
        self.moviePoster.loadImageFromUrl(urlString: StaticEndpoint.remoteImagesEndpoint + poster)
    }
    
    // MARK: - Cell Elements
    
    private let moviePoster: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    
    // MARK: - UI Configuration
    
    private func updateUI() {
        moviePoster.frame = self.contentView.bounds
        _ = self.roundedCornersMaxCurve
    }
    
    // MARK: - Constraints
    
    private func initializeConstraints() {
        let constraints = [NSLayoutConstraint]()
        
        NSLayoutConstraint.activate(constraints)
        
    }
}
