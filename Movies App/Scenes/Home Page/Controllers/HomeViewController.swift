//
//  ViewController.swift
//  Movies App
//
//  Created by aleksandre on 25.12.21.
//

import MSPeekCollectionViewDelegateImplementation
import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Self identifier
    private(set) static var identifier = "HomeViewController"
    
    // MARK: - IBOutlets
    
    
    // MARK: - Instances
    
    private var trendingMovies = [Movie]()
    private var upcomingMovies = [Movie]()
    
    
    // Cell peek behavior configuration
    private var behavior = MSCollectionViewPeekingBehavior(cellSpacing: 15, cellPeekWidth: 40)
    
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        populateStackView()
        initializeCollectionView()
        initializeConstraints()
        
        // Network calls
        NetworkEngine.request(endpoint: MoviesDbEndpoint.dailyTrends) { (result: Result<TrendingMoviesResponse, Error>) in
            switch result {
            case .success(let response):
                self.trendingMovies = response.results
                self.trendingMoviesCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        NetworkEngine.request(endpoint: MoviesDbEndpoint.moviesGenres) { (result :Result<GenresResponse, Error>) in
            switch result {
            case .success(let success):
                // append fetched data into dictionary with ID as key and name as value
                for genre in success.genres {
                    GenresDataBase.setGenreData(genre.id, name: genre.name)
                }
                self.trendingMoviesCollectionView.reloadData()
            case .failure(let failure):
                print(failure)
            }
        }
        NetworkEngine.request(endpoint: MoviesDbEndpoint.comingSoon) { (result: Result<UpcomingMoviesResponse, Error>) in
            switch result {
            case .success(let success):
                self.upcomingMovies = success.results
                self.upcomingMoviesCollectionView.reloadData()
            case .failure(let failure):
                print(failure)
            }
        }
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateUI()
    }
    
    // adding SubViews
    private func addSubviews() {
        self.view.addSubview(upperStackView)
        self.view.addSubview(categoriesStackView)
        self.view.addSubview(trendingMoviesCollectionView)
        self.view.addSubview(upcomingMoviesCollectionView)
        self.view.addSubview(trendingLabel)
        self.view.addSubview(topRatedLabel)
        self.view.addSubview(topRatedMoviesExtensionButton)
    }
    
    // adding arrangedSubViews into stackView
    private func populateStackView() {
        /// upper stackview
        upperStackView.addArrangedSubview(optionMenu)
        upperStackView.addArrangedSubview(nfLogo)
        upperStackView.addArrangedSubview(searchButton)
        /// middle stackView
        categoriesStackView.addArrangedSubview(tvShowsButton)
        categoriesStackView.addArrangedSubview(moviesButton)
        categoriesStackView.addArrangedSubview(myListButton)
    }
    
    
    // MARK: - UI update
    
    private func updateUI() {
        self.view.backgroundColor = UIColor.mainAppColor
        _ = myListButton.roundedCorners
        _ = moviesButton.roundedCorners
        _ = tvShowsButton.roundedCorners
        
    }
    
    // MARK: - ContentView
    
    // Netflix logo
    private let nfLogo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Netflix_Logo")
        image.contentMode = .scaleToFill
        return image
    }()
    
    // Menu Option
    private let optionMenu: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "menu2"), for: .normal)
        return button
    }()
    
    // TV shows button
    private let tvShowsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("TV Shows", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 15)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .appRedColor
        return button
    }()
    
    // Movies Button
    private let moviesButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Movies", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 15)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .appRedColor
        return button
    }()
    
    // MyList button
    private let myListButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("My List", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 15)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .appRedColor
        return button
    }()
    
    // top rated movies collectionView extension button
    private let topRatedMoviesExtensionButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.appDarkRedColor, for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 13)
        return button
    }()
    
    // SearchBar
    private let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "search_icon"), for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    // Trending Label
    private let trendingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline)
        label.text = "Trending this week"
        label.textColor = .white
        return label
    }()
    
    // ComingSoon label
    private let topRatedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Coming Soon"
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    // MARK: - StackView Configuration
    
    // Upper StackView
    private let upperStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.isUserInteractionEnabled = true
        stackView.distribution = .fill
        stackView.spacing = 40
        return stackView
    }()
    
    // Categories StackView
    private let categoriesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.isUserInteractionEnabled = true
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    
    // MARK: - CollectionView Configuration
    
    // Upcoming Collection View
    private let trendingMoviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // Upcoming Movies Collection View
    private let upcomingMoviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private func initializeCollectionView() {
        /// Trending Movies CollectionView
        trendingMoviesCollectionView.register(TrendingMoviesCollectionViewCell.self, forCellWithReuseIdentifier: TrendingMoviesCollectionViewCell.identifier)
        trendingMoviesCollectionView.dataSource = self
        trendingMoviesCollectionView.delegate = self
        
        /// Cells peeking from sides type custom behavior
        trendingMoviesCollectionView.configureForPeekingBehavior(behavior: behavior)
    
        /// Upcoming Movies CollectionView
        upcomingMoviesCollectionView.register(UpcomingMoviesCollectionViewCell.self, forCellWithReuseIdentifier: UpcomingMoviesCollectionViewCell.identifier)
        upcomingMoviesCollectionView.dataSource = self
        upcomingMoviesCollectionView.delegate = self
    }
    
    
    
    // MARK: - CollectionView Delegate Methods
    
    // Cell count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
            /// Value for Upcoming movies collectionView
        case self.upcomingMoviesCollectionView: return trendingMovies.count
        default: break
        }
        /// Default value for trending movies collectionView
        return trendingMovies.count
    }
    
    // Cell configuration
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
            /// Cell for upcoming movies collectionView
        case self.upcomingMoviesCollectionView:
            let cell = upcomingMoviesCollectionView.dequeueReusableCell(withReuseIdentifier: UpcomingMoviesCollectionViewCell.identifier, for: indexPath) as!
            UpcomingMoviesCollectionViewCell
            cell.initializeCellContent(upcomingMovies[indexPath.row])
            return cell
        default: break
        }
        /// Default cell for trending movies collectionView
        let cell = trendingMoviesCollectionView.dequeueReusableCell(withReuseIdentifier: TrendingMoviesCollectionViewCell.identifier, for: indexPath) as! TrendingMoviesCollectionViewCell
        cell.initializeCellContent(trendingMovies[indexPath.row])
        return cell
        
    }
    
    // Cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
            /// Cell size for upcoming movies collectionView
        case self.upcomingMoviesCollectionView:
            return CGSize(width: collectionView.bounds.width / 4, height: collectionView.bounds.height)
        default: break
        }
        /// Trending movies collectionView cell size
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    // Spacing between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case self.upcomingMoviesCollectionView:
            return 15
        default: break
        }
        return 0
    }
    
    // Cell scrolling behavior configuration for only trendingMoviesCollectionView
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard scrollView == trendingMoviesCollectionView else { return }
        behavior.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    
    
    // MARK: - Constraints
    
    private func initializeConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Constants
        let leadingSpace = CGFloat(24)
        let trailingSpace = CGFloat(-24)
        let paddingBetweenItems = CGFloat(20)
        let stackViewHeight = CGFloat(44)
        
        // Upper stackview
        constraints.append(upperStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 54))
        constraints.append(upperStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor))
        constraints.append(upperStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: leadingSpace))
        constraints.append(upperStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: trailingSpace))
        constraints.append(upperStackView.heightAnchor.constraint(equalToConstant: stackViewHeight))
        
        // Categories stackview
        constraints.append(categoriesStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: leadingSpace))
        constraints.append(categoriesStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: trailingSpace))
        constraints.append(categoriesStackView.topAnchor.constraint(equalTo: trendingMoviesCollectionView.bottomAnchor, constant: paddingBetweenItems))
        constraints.append(categoriesStackView.heightAnchor.constraint(equalToConstant: stackViewHeight))
        
        // Option menu
        constraints.append(optionMenu.widthAnchor.constraint(equalToConstant: 24))
        
        
        // Search button
        constraints.append(searchButton.widthAnchor.constraint(equalToConstant: 24))
        
        // Trending label
        constraints.append(trendingLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: leadingSpace))
        constraints.append(trendingLabel.topAnchor.constraint(equalTo: upperStackView.bottomAnchor, constant: paddingBetweenItems))
        
        // Top rated label
        constraints.append(topRatedLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: leadingSpace))
        constraints.append(topRatedLabel.topAnchor.constraint(equalTo: categoriesStackView.bottomAnchor, constant: paddingBetweenItems))
        
        // Upcoming movies extension button
        constraints.append(topRatedMoviesExtensionButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: trailingSpace))
        constraints.append(topRatedMoviesExtensionButton.centerYAnchor.constraint(equalTo: topRatedLabel.centerYAnchor))
        
        // Trending movies collectionView
        constraints.append(trendingMoviesCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0))
        constraints.append(trendingMoviesCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0))
        constraints.append(trendingMoviesCollectionView.topAnchor.constraint(equalTo: trendingLabel.bottomAnchor, constant: paddingBetweenItems))
        constraints.append(trendingMoviesCollectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2))
        
        // Upcoming collectionView
        constraints.append(upcomingMoviesCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: leadingSpace))
        constraints.append(upcomingMoviesCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0))
        constraints.append(upcomingMoviesCollectionView.topAnchor.constraint(equalTo: topRatedLabel.bottomAnchor, constant: paddingBetweenItems))
        constraints.append(upcomingMoviesCollectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.17))
        
        NSLayoutConstraint.activate(constraints)
        
    }
}



