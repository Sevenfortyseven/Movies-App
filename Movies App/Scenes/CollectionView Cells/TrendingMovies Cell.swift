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
        self.layer.cornerRadius = 6
        self.clipsToBounds = true
        addSubviews()
        populateStackView()
        initializeConstraints()
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
        self.contentView.addSubview(moviesInfo)
    }
    
    // Populate stackView with arrangedSubviews
    private func populateStackView() {
        moviesInfo.addArrangedSubview(movieTitle)
        moviesInfo.addArrangedSubview(moviesGenre)
        moviesInfo.addArrangedSubview(moviesReleaseDate)
    }
    
    // Initialize Cell content
    public func initializeCellContent(_ movie: Movie) {
        
        self.moviePoster.loadImageFromUrl(urlString: "https://image.tmdb.org/t/p/w500" + movie.backdropPath)
        self.movieTitle.text = movie.title
        self.moviesGenre.text = GenresDataBase.getGenreData(movie.genreIDs)
        self.moviesReleaseDate.text = movie.releaseDate.YearFormat
    }
    
    // MARK: - Cell ContentView
    
    private let moviePoster: UIImageView = {
        let moviePoster = UIImageView()
        moviePoster.contentMode = .scaleToFill
        return moviePoster
    }()
    
    private let movieTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 2
        return label
    }()
    
    private let moviesGenre: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightText
        label.font = .preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    private let moviesReleaseDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightText
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    // MARK: StackView Configuration
    
    private let moviesInfo: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    // MARK: - Update UI
    
    private func updateUI() {
        moviePoster.frame = self.contentView.bounds
    }
    
    
    // MARK: Constraints
    
    private func initializeConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        
        // StackView
        constraints.append(moviesInfo.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10))
        constraints.append(moviesInfo.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -5))
        constraints.append(moviesInfo.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor, constant: -15))
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
