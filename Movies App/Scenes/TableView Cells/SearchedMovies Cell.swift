//
//  SearchedMovies Cell.swift
//  Movies App
//
//  Created by aleksandre on 17.01.22.
//

import Foundation
import UIKit

class SearchedMoviesTableViewCell: UITableViewCell  {
    
    // Self identifier
    private(set) static var identifier = "SearchedMoviesTableViewCell"
    
    // MARK: Instances
    
    // MARK: Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        initializeStackView()
        initializeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .mainAppColor
    }
    
    // Add subviews
    private func addSubviews() {
        self.contentView.addSubview(movieDetailsStackView)
        self.contentView.addSubview(moviePoster)
    }
    
    // Add arranged subviews into stackView
    private func initializeStackView() {
        movieDetailsStackView.addArrangedSubview(movieTitle)
        movieDetailsStackView.addArrangedSubview(movieReleaseDate)
        movieDetailsStackView.addArrangedSubview(movieGenre)
    }
    
    // Cell content initialization
    public func initializeCellContent(_ movie: Movie?) {
      
        guard let poster = movie?.posterPath else  {
            print("no poster url")
            return
        }
        
        self.moviePoster.loadImageFromUrl(urlString: StaticEndpoint.remoteImagesEndpoint + poster)
        self.movieTitle.text = movie!.title
        self.movieGenre.text = GenresDataBase.getGenreData(movie!.genreIDs)
        self.movieReleaseDate.text = movie!.releaseDate
    }
    
    
    // MARK: UI Config
    
    // MARK: ContentView
    
    // Movie poster imageView
    private let moviePoster: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Movie title label
    private let movieTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    // Movie genre label
    private let movieGenre: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    // Movie release date
    private let movieReleaseDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    // MARK: - StackView Configuration
    
    private let movieDetailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    // MARK: Constraints
    
    private func initializeConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Movie poster
        constraints.append(moviePoster.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0))
        constraints.append(moviePoster.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0))
        constraints.append(moviePoster.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0))
        constraints.append(moviePoster.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.5))
        
        // Movie details stackView
        constraints.append(movieDetailsStackView.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 10))
        constraints.append(movieDetailsStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15))
        constraints.append(movieDetailsStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5))
        
        NSLayoutConstraint.activate(constraints)
    }
    
}