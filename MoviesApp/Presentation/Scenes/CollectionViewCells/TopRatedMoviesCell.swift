//
//  TopRatedMovies Cell.swift
//  Movies App
//
//  Created by aleksandre on 11.01.22.
//

import Foundation
import UIKit

class TopRatedMoviesCollectionViewCell: UICollectionViewCell {
    
    private(set) static var identifier = "TopRatedMoviesCollectionViewCell"
    
    // MARK: - Instances
    
    
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        updateUI()
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    // Populate view with subviews
    private func addSubviews(){
        self.contentView.addSubview(moviePoster)
        
    }
    
    // Initialize cell content
    public func initializeCellContent(_ movie: Movie?) {
        guard let poster = movie?.posterPath else {
            print("error while initializing cell content")
            return
        }
        self.moviePoster.loadImageFromUrl(urlString: StaticEndpoint.remoteImagesEndpoint + poster)
    }
    
    // MARK: - Cell Elements
    
    private let moviePoster: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    
    // MARK: - UI Configuration
    
    private func updateUI() {
        moviePoster.frame = self.contentView.bounds
        _ = self.roundedCornersMaxCurve
    }
    
    
    // MARK: - Constraints
    
    
}
