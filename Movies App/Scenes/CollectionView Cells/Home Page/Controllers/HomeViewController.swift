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
    
    private var movies = [Movie]()
    
    
    // Cell peek behavior configuration
    private var behavior = MSCollectionViewPeekingBehavior(cellSpacing: 15, cellPeekWidth: 40)
    
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        populateStackView()
        initializeCollectionView()
        initializeConstraints()
        
        // Network calls
        NetworkEngine.request(endpoint: MoviesDbEndpoint.dailyTrends) { (result: Result<MoviesResponse, Error>) in
            switch result {
            case .success(let response):
                self.movies = response.results
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
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateUI()
    }
    
    // adding SubViews
    private func addSubViews() {
        self.view.addSubview(upperStackView)
        self.view.addSubview(categoriesStackView)
        self.view.addSubview(trendingMoviesCollectionView)
        self.view.addSubview(trendingLabel)
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
        // Cells peeking from sides type behavior
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
        label.font = .preferredFont(forTextStyle: .headline, compatibleWith: .current)
        label.text = "Trending this week"
        label.textColor = .white
        return label
    }()
    
    // TV shows button
    private let tvShowsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("TV Shows", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        return button
    }()
    
    // Movies Button
    private let moviesButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Movies", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        return button
    }()
    
    // MyList button
    private let myListButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("My List", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        return button
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
    
    // Middle StackView
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
    
    private let trendingMoviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private func initializeCollectionView() {
        trendingMoviesCollectionView.register(TrendingMoviesCollectionViewCell.self, forCellWithReuseIdentifier: TrendingMoviesCollectionViewCell.identifier)
        trendingMoviesCollectionView.dataSource = self
        trendingMoviesCollectionView.delegate = self
        trendingMoviesCollectionView.configureForPeekingBehavior(behavior: behavior)
    }
    
    
    
    // MARK: - CollectionView Delegate Methods
    
    // Cell count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    // Cell configuration
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = trendingMoviesCollectionView.dequeueReusableCell(withReuseIdentifier: TrendingMoviesCollectionViewCell.identifier, for: indexPath) as! TrendingMoviesCollectionViewCell
        cell.initializeCellContent(movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    
    // Cell behavior configuration
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        behavior.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    // MARK: - Constraints
    
    private func initializeConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // constants
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
        
        // Middle stackview
        constraints.append(categoriesStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: leadingSpace))
        constraints.append(categoriesStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: trailingSpace))
        constraints.append(categoriesStackView.topAnchor.constraint(equalTo: trendingMoviesCollectionView.bottomAnchor, constant: paddingBetweenItems))
        constraints.append(categoriesStackView.heightAnchor.constraint(equalToConstant: stackViewHeight))
        
        // option menu
        constraints.append(optionMenu.widthAnchor.constraint(equalToConstant: 24))
        
        
        // search button
        constraints.append(searchButton.widthAnchor.constraint(equalToConstant: 24))
        
        // trending label
        constraints.append(trendingLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: leadingSpace))
        constraints.append(trendingLabel.topAnchor.constraint(equalTo: upperStackView.bottomAnchor, constant: paddingBetweenItems))
        
        // trending movies collectionView
        constraints.append(trendingMoviesCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor))
        constraints.append(trendingMoviesCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0))
        constraints.append(trendingMoviesCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0))
        constraints.append(trendingMoviesCollectionView.topAnchor.constraint(equalTo: trendingLabel.bottomAnchor, constant: paddingBetweenItems))
        constraints.append(trendingMoviesCollectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2))

        
        NSLayoutConstraint.activate(constraints)
        
    }
}



