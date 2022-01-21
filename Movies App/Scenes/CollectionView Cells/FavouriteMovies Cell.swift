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
        initializeConstraints()
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
        self.contentView.addSubview(dismissFromFavouritesButton)
    }
    
    public func initializeContentView(_ movie: Movie) {
        let url = StaticEndpoint.remoteImagesEndpoint + movie.posterPath!
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

    private let dismissFromFavouritesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.tintColor = .appRedColor
        button.addTarget(self, action: #selector(removeMovieFromFavourites), for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    //MARK: - Button actions
    
    // Send notifications that button was pressed
    @objc private func removeMovieFromFavourites() {
        NotificationCenter.default.post(name: .removeFromFavourites , object: self)
    }
    
    //MARK: - Constraints
    
    private func initializeConstraints() {
        var constraints = [NSLayoutConstraint]()
        let topPadding = CGFloat(10)
        let trailingPadding = CGFloat(-10)
        let buttonSize = CGFloat(40)
    
        // Remove from favourites button
        constraints.append(dismissFromFavouritesButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: topPadding))
        constraints.append(dismissFromFavouritesButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: trailingPadding))
        constraints.append(dismissFromFavouritesButton.heightAnchor.constraint(equalToConstant: buttonSize))
        constraints.append(dismissFromFavouritesButton.widthAnchor.constraint(equalToConstant: buttonSize))
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
}
