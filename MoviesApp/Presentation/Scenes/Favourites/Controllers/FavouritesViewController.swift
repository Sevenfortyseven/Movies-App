//
//  FavouritesViewController.swift
//  Movies App
//
//  Created by aleksandre on 11.01.22.
//

import Foundation
import UIKit

class FavouritesViewController: UIViewController, FavouriteMoviesDelegate {
    
    // Self identifier
    private(set) static var identifier = "FavouritesViewController"
    
    // MARK: - Instances
    
    private var favouriteMovies = [Movie]()
    private var deletedMovies = [Movie]()
    
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        InitializeCollectionView()
        initializeConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTheme()
        
    }
    
    // Add subviews
    private func addSubviews() {
        self.view.addSubview(yourMoviesLabel)
        self.view.addSubview(favouriteMoviesCollectionView)
    }
    
    // MARK: - UI configuration

    private func updateTheme() {
        let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        if isDarkMode {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
        self.view.backgroundColor = .primaryColor
        self.favouriteMoviesCollectionView.backgroundColor = .clear
    }
    
    // MARK: - UI Elements
    
    // Your movies label
    private let yourMoviesLabel: UILabel = {
        let label = UILabel()
        label .translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .tertiaryColor
        label.font = .preferredFont(forTextStyle: .headline)
        label.text = "Your Movies"
        return label
    }()
    
    // MARK: - CollectionView Configuration
    private let favouriteMoviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    
    
    // MARK: - Delegate Methods
    
    // appends given movie object into self movies array
    func addMovie(_ movie: Movie) {
        self.favouriteMovies.append(movie)
        self.favouriteMoviesCollectionView.reloadData()
        
    }
    
    // Removes movie from self movies array
    func removeMovie(_ movie: Movie) {
        self.favouriteMovies.removeAll(where: { $0.movieId == movie.movieId})
        self.favouriteMoviesCollectionView.reloadData()
    }
    
}



// MARK: - CollectionView Configuration and Delegate Methods

extension FavouritesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Register collectionView
    private func InitializeCollectionView() {
        favouriteMoviesCollectionView.register(FavouriteMoviesCollectionViewCell.self, forCellWithReuseIdentifier: FavouriteMoviesCollectionViewCell.identifier)
        favouriteMoviesCollectionView.delegate = self
        favouriteMoviesCollectionView.dataSource = self
    }
    
    
    // Cell count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouriteMovies.count
    }
    
    // Cell configuration
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favouriteMoviesCollectionView.dequeueReusableCell(withReuseIdentifier: FavouriteMoviesCollectionViewCell.identifier, for: indexPath) as! FavouriteMoviesCollectionViewCell
        cell.initializeContentView(favouriteMovies[indexPath.row])
        return cell
    }
    // Cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.size.width
        let cellHeight = collectionView.frame.size.height / 1.5
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    // Spacing between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    // Cell action
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = favouriteMovies[indexPath.row]
        let targetVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: DetailsViewController.identifier) as! DetailsViewController
        targetVC.movie = selectedMovie
        targetVC.genreIDs = selectedMovie.genreIDs
        targetVC.changeToFavouriteDelegate = self
        navigationController?.present(targetVC, animated: true, completion: nil)
        
    }
    
}


// MARK: - Constraints

extension FavouritesViewController {
    
    private func initializeConstraints() {
        var constraints = [NSLayoutConstraint]()
        let leadingSpace = CGFloat(24)
        let trailingSpace = CGFloat(-24)
        let paddingBetweenItems = CGFloat(10)
        
        // Your movies label
        constraints.append(yourMoviesLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: leadingSpace))
        constraints.append(yourMoviesLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5))
        
        // CollectionView
        constraints.append(favouriteMoviesCollectionView.topAnchor.constraint(equalTo: yourMoviesLabel.bottomAnchor, constant: paddingBetweenItems))
        constraints.append(favouriteMoviesCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: leadingSpace))
        constraints.append(favouriteMoviesCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: trailingSpace))
        constraints.append(favouriteMoviesCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
}
