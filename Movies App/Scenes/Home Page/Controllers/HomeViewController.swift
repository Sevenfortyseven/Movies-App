//
//  ViewController.swift
//  Movies App
//
//  Created by aleksandre on 25.12.21.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Self identifier
    private(set) static var identifier = "HomeViewController"
    
    // MARK: - IBOutlets
    
    
    // MARK: - Instances
    
    private var movies = [Movie]()
    
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        addSubViews()
        populateStackView()
        initializeCollectionView()
        initializeConstraints()
        NetworkEngine.request(endpoint: MoviesDbEndpoint.dailyTrends) { (result: Result<MoviesResponse, Error>) in
            switch result {
            case .success(let response): self.movies = response.results; self.trendingMoviesCollectionView.reloadData()
            case .failure(let error): print(error)
            }
        }
       
    }
    
    
    // adding SubViews
    private func addSubViews() {
        self.view.addSubview(upperStackView)
        self.view.addSubview(trendingMoviesCollectionView)
    }
    
    // adding arrangedSubViews into stackView
    private func populateStackView() {
        upperStackView.addArrangedSubview(optionMenu)
        upperStackView.addArrangedSubview(nfLogo)
        upperStackView.addArrangedSubview(searchButton)
    }
    
    
    // MARK: - UI update
    
    private func updateUI() {
        self.view.backgroundColor = UIColor.mainAppColor
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
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "menu2"), for: .normal)
        return button
    }()
    
    // SearchBar
    private let searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "search_icon"), for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
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
    
    // MARK: - CollectionView Configuration
    
    private let trendingMoviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        layout.estimatedItemSize = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .brown
        return collectionView
    }()
    
    private func initializeCollectionView() {
        trendingMoviesCollectionView.register(TrendingMoviesCollectionViewCell.self, forCellWithReuseIdentifier: TrendingMoviesCollectionViewCell.identifier)
        trendingMoviesCollectionView.dataSource = self
        trendingMoviesCollectionView.delegate = self
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
    
    // Cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: trendingMoviesCollectionView.bounds.width , height: trendingMoviesCollectionView.bounds.height)
    }
    

    
    // MARK: - Constraints
    
    private func initializeConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Upper stackview
        constraints.append(upperStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 54))
        constraints.append(upperStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor))
        constraints.append(upperStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 24))
        constraints.append(upperStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -24))
        constraints.append(upperStackView.heightAnchor.constraint(equalToConstant: 44))
        
        // option menu
        constraints.append(optionMenu.widthAnchor.constraint(equalToConstant: 24))
        
        
        // search button
        constraints.append(searchButton.widthAnchor.constraint(equalToConstant: 24))
        
        // trending movies collectionView
        constraints.append(trendingMoviesCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor))
        constraints.append(trendingMoviesCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0))
        constraints.append(trendingMoviesCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0))
        constraints.append(trendingMoviesCollectionView.topAnchor.constraint(equalTo: upperStackView.bottomAnchor, constant: 30))
        constraints.append(trendingMoviesCollectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2))
        
        NSLayoutConstraint.activate(constraints)
        
    }
}



