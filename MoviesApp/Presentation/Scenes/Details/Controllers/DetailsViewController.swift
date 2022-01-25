//
//  DetailsPageController.swift
//  Movies App
//
//  Created by aleksandre on 11.01.22.
//

import Foundation
import UIKit
import WebKit
import MarqueeLabel

class DetailsViewController: UIViewController, WKNavigationDelegate {
    
    // Self identifier
    private(set) static var identifier = "DetailsViewController"
    
    
    // MARK: - Instances
    private let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
    public var movie: Movie?
    public var genreIDs: [Int]?
    private var video = [Video]()
    private var YTkey: String?
    private var userReviews = [UserReview]()
    private static var favouriteMovies = [Movie]()
    weak var changeToFavouriteDelegate: FavouriteMoviesDelegate?
    
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkInAction()
        addSubviews()
        populateStackView()
        initializeTableView()
        initializeConstraints()
        checkMovie()
        updateUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        spinner.startAnimating()
        print("ViewWillAppear")
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateFrames()
        
    }
    
    
    // Populate view with subviews
    private func addSubviews() {
        self.view.addSubview(webView)
        self.view.addSubview(spinner)
        self.view.addSubview(movieTitle)
        self.view.addSubview(userReviewsTableView)
        self.view.addSubview(movieInfoStackView)
        self.view.addSubview(buttonsStackView)
        self.view.addSubview(movieDescriptionView)
        self.view.addSubview(reviewsLabel)
    }
    
    // Populate stackview with arranged subviews
    private func populateStackView() {
        movieInfoStackView.addArrangedSubview(movieGenre)
        movieInfoStackView.addArrangedSubview(separator1)
        movieInfoStackView.addArrangedSubview(movieReleaseDate)
        movieInfoStackView.addArrangedSubview(separator2)
        movieInfoStackView.addArrangedSubview(movieRating)
        
        buttonsStackView.addArrangedSubview(addToFavouritesButton)
        buttonsStackView.addArrangedSubview(downloadButton)
        buttonsStackView.addArrangedSubview(shareButton)
    }
    
    // Initialize view content
    private func initializeContentView() {
        initializeWebView()
        movieTitle.text = movie!.title
        movieGenre.text = GenresDataBase.getGenreData(genreIDs!)
        movieReleaseDate.text = movie?.releaseDate.YearFormat
        movieRating.text = "Imdb " + String(movie!.averageVote)
        movieDescriptionView.text = movie!.overview
    }
    
    // Checks if movie is marked as favourite and updates button colour accordingly
    private func checkMovie() {
        for favMovie in DetailsViewController.favouriteMovies {
            if movie?.movieId == favMovie.movieId {
                self.addToFavouritesButton.tintColor = .appRedColor
            }
        }
    }
    
    // MARK: - UI Configuration
    
    private func updateUI() {
        updateTheme()
        self.view.clipsToBounds = true
    
    }
    
    private func updateTheme() {
        self.view.backgroundColor = .primaryColor
        self.userReviewsTableView.backgroundColor = .clear
        if isDarkMode {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
    }
    
    // Update frames
    private func updateFrames() {
        spinner.center = webView.center
        movieGenre.setContentHuggingPriority(.defaultLow, for: .horizontal)
        movieGenre.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    
    
    
    // MARK: - UI Elements
    
    //AVplayer view
    private let webView: WKWebView = {
        var webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.isOpaque = false
        return webView
    }()
    
    // Title label
    private let movieTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title1)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.textColor = .tertiaryColor
        return label
    }()
    
    // Movie genre, continiously moving label
    private let movieGenre: MarqueeLabel = {
        let label = MarqueeLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.type = .continuous
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .tertiaryColor
        label.numberOfLines = 0
        return label
    }()
    
    // Movie release date
    private let movieReleaseDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .tertiaryColor
        return label
    }()
    
    // Movie average rating
    private let movieRating: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .tertiaryColor
        return label
    }()
    
    // Add to favourites button
    private let addToFavouritesButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.imagePlacement = .top
        let button = UIButton(configuration: config, primaryAction: .none)
        button.addTarget(self, action: #selector(markAsFavourite), for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.setTitleColor(.tertiaryColor, for: .normal)
        button.tintColor = .gray
        button.setTitle("Favourite", for: .normal)
        return button
    }()
    
    // Download button
    private let downloadButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.imagePlacement = .top
        let button = UIButton(configuration: config, primaryAction: .none)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.tertiaryColor, for: .normal)
        button.tintColor = .gray
        button.setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
        button.setTitle("Download", for: .normal)
        return button
    }()
    
    // Share button
    private let shareButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.imagePlacement = .top
        let button = UIButton(configuration: config, primaryAction: .none)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.tertiaryColor, for: .normal)
        button.setTitle("Share", for: .normal)
        button.tintColor = .gray
        button.setImage(UIImage(systemName: "square.and.arrow.up.fill"), for: .normal)
        return button
    }()
    
    // Movie Description
    private let movieDescriptionView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.textColor = .gray
        textView.isScrollEnabled = false
        textView.sizeToFit()
        textView.font = .preferredFont(forTextStyle: .footnote)
        textView.backgroundColor = .clear
        return textView
    }()
    
    // Reviews label
    private let reviewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .tertiaryColor
        label.text = "Reviews"
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    
    // Activity indicator
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.style = .large
        return spinner
    }()
    
    private let movieInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 15
        return stackView
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    // StackView separator
    private let separator1: UIView = {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .appRedColor
        return separator
    }()
    
    // StackView separator
    private let separator2: UIView = {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .appRedColor
        return separator
    }()
    
    // User reviews tableView
    private let userReviewsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        return tableView
    }()
    
    // MARK: - WebView Configuration and Delegate Methods
    
    
    // Initialize webView content
    private func initializeWebView() {
        webView.navigationDelegate = self
        
        for key in video {
            self.YTkey = key.key
        }
        guard YTkey != nil else {
            print("no YT key available")
            return
        }
        
        let embedURL = StaticEndpoint.YTendpoint + YTkey!
        let url = URL(string: embedURL)
        guard url != nil else {
            print("invalid url")
            return
        }
        let request = URLRequest(url: url!)
        webView.load(request)
        
    }
    
    // Checks webView navigation state to stop activity indicator
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        spinner.stopAnimating()
    }
    
    
    // MARK: - Button Actions
    
    @objc private func markAsFavourite() {
        
        guard let favouriteMovie = movie else {
            print("invalid movie object")
            return
        }
        // check whether the movie is already added into favourite movies array
        if !DetailsViewController.favouriteMovies.contains(where: { favouriteMovie.movieId == $0.movieId }) {
            addToFavouritesButton.tintColor = .appRedColor
            DetailsViewController.favouriteMovies.append(favouriteMovie)
            changeToFavouriteDelegate?.addMovie(favouriteMovie)
        } else {
            addToFavouritesButton.tintColor = .gray
            DetailsViewController.favouriteMovies.removeAll(where: { $0.movieId == favouriteMovie.movieId})
            changeToFavouriteDelegate?.removeMovie(favouriteMovie)
        }
        
    }
    
}

// MARK: - Networking

extension DetailsViewController {
    
    
    private func networkInAction() {
        guard movie != nil else {
            print("movie id not available")
            return
        }
        // Network request to get YT video key
        NetworkEngine.request(endpoint: MoviesDbEndpoint.movieTrailer(movieID: movie!.movieId)) { (result: Result<VideosResponse, Error>) in
            switch result {
            case .success(let response):
                self.video = response.results
                self.initializeContentView()
            case .failure(let error):
                print(error)
            }
        }
        // Network request to get user reviews
        NetworkEngine.request(endpoint: MoviesDbEndpoint.userReviews(movieID: movie!.movieId)) { (result: Result<UserReviewsResponse, Error>) in
            switch result {
            case .success(let response):
                self.userReviews = response.results
                self.userReviewsTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}


// MARK: - TableView Configuration and Delegate Methods

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    private func initializeTableView() {
        userReviewsTableView.register(UserReviewsTableViewCell.self, forCellReuseIdentifier: UserReviewsTableViewCell.identifier)
        userReviewsTableView.delegate = self
        userReviewsTableView.dataSource = self
    }
    
    
    // Number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  userReviews.count
    }
    
    // Cell configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userReviewsTableView.dequeueReusableCell(withIdentifier: UserReviewsTableViewCell.identifier) as! UserReviewsTableViewCell
        cell.initializeContentView(userReviews[indexPath.row])
        return cell
    }
    
    // Cell size
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
        
    }


}

// MARK: - Constraints

extension DetailsViewController {
    
    
    
    private func initializeConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Constants
        let leadingSpace = CGFloat(24)
        let trailingSpace = CGFloat(-24)
        let paddingBetweenItems = CGFloat(10)
        let stackViewHeight = CGFloat(50)
        let separatorWidth = CGFloat(2)
        
        //AVplayer view
        constraints.append(webView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0))
        constraints.append(webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0))
        constraints.append(webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0))
        constraints.append(webView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4))
        
        
        // Spinner View
        constraints.append(spinner.centerXAnchor.constraint(equalTo: webView.centerXAnchor))
        constraints.append(spinner.centerYAnchor.constraint(equalTo: webView.centerYAnchor))
        
        // Movie title
        constraints.append(movieTitle.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: paddingBetweenItems))
        constraints.append(movieTitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor))
        constraints.append(movieTitle.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: leadingSpace))
        constraints.append(movieTitle.trailingAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: trailingSpace))
        
        // Movie Info stackview
        constraints.append(movieInfoStackView.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: paddingBetweenItems))
        constraints.append(movieInfoStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor))
        constraints.append(movieGenre.widthAnchor.constraint(equalTo: movieInfoStackView.widthAnchor, multiplier: 0.33))
        constraints.append(movieReleaseDate.centerXAnchor.constraint(equalTo: movieInfoStackView.centerXAnchor))
        
        // Buttons stackView
        constraints.append(buttonsStackView.topAnchor.constraint(equalTo: movieInfoStackView.bottomAnchor, constant: paddingBetweenItems))
        constraints.append(buttonsStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor))
        constraints.append(buttonsStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: leadingSpace))
        constraints.append(buttonsStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: trailingSpace))
        constraints.append(buttonsStackView.heightAnchor.constraint(equalToConstant: stackViewHeight))
        
        // StackView separators
        constraints.append(separator1.widthAnchor.constraint(equalToConstant: separatorWidth))
        constraints.append(separator2.widthAnchor.constraint(equalToConstant: separatorWidth))
        constraints.append(separator1.heightAnchor.constraint(equalTo: movieInfoStackView.heightAnchor))
        constraints.append(separator2.heightAnchor.constraint(equalTo: movieInfoStackView.heightAnchor))
        
        // Movie description textView
        constraints.append(movieDescriptionView.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: paddingBetweenItems))
        constraints.append(movieDescriptionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: leadingSpace))
        constraints.append(movieDescriptionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: trailingSpace))
        
        // Reviews label
        constraints.append(reviewsLabel.topAnchor.constraint(equalTo: movieDescriptionView.bottomAnchor, constant: paddingBetweenItems))
        constraints.append(reviewsLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: leadingSpace))
        
        // User reviews tableView
        constraints.append(userReviewsTableView.topAnchor.constraint(equalTo: reviewsLabel.bottomAnchor, constant: paddingBetweenItems))
        constraints.append(userReviewsTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: leadingSpace))
        constraints.append(userReviewsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: trailingSpace))
        constraints.append(userReviewsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0))
        
        NSLayoutConstraint.activate(constraints)
    }
}

