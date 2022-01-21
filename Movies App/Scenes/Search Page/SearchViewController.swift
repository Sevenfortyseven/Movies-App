//
//  SearchViewController.swift
//  Movies App
//
//  Created by aleksandre on 15.01.22.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
  
    private(set) static var identifier = "SearchViewController"
    
    // MARK: - Instances
    
    private var filteredMovies = [Movie]()
    
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        initializeConstraints()
        initializeTableView()
        initializeSearchBar()
        populateStackView()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateUI()

    }
    
    // Populate view with subviews
    private func addSubviews() {
        self.view.addSubview(searchBar)
        self.view.addSubview(genreButtonsStackView)
        self.view.addSubview(favouriteGenreLabel)
        self.view.addSubview(searchResultLabel)
        self.view.addSubview(searchResultTableView)

    }
    
    // populate stackView with arranged subviews
    private func populateStackView() {
        genreButtonsStackView.addArrangedSubview(favouriteGenreButton1)
        genreButtonsStackView.addArrangedSubview(favouriteGenreButton2)
        genreButtonsStackView.addArrangedSubview(favouriteGenreButton3)
        genreButtonsStackView.layoutIfNeeded()
    }
    
    // MARK: - UI Config
    
    private func updateUI() {
        self.view.backgroundColor = .mainAppColor
        searchResultTableView.backgroundColor = .clear
        _ = favouriteGenreButton1.roundedCornersMinCurve
        _ = favouriteGenreButton2.roundedCornersMinCurve
        _ = favouriteGenreButton3.roundedCornersMinCurve
        

    }
    
    // MARK: - Content View
    
    
    // Search Textfield
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.autocorrectionType = .no
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.leftView?.tintColor = .appRedColor
        return searchBar
    }()
    
    // Favourite genres label
    private let favouriteGenreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline)
        label.text = "Your Favourite Genre"
        label.textColor = .white
        return label
    }()
    
    // Search result label
    private let searchResultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline)
        label.text = "Search Result"
        label.textColor = .white
        return label
    }()
    
    // Button for searching by favourite genres
    private let favouriteGenreButton1: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 15)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .appRedColor
        return button
    }()
    
    // Button for searching by favourite genres
    private let favouriteGenreButton2: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 15)
        button.backgroundColor = .appRedColor
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    // Button for searching by favourite genres
    private let favouriteGenreButton3: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 15)
        button.backgroundColor = .appRedColor
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    
    // MARK: - StackView Configuration
    
    // stackView for genre buttons
    private let genreButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.isUserInteractionEnabled = true
        stackView.spacing = 20
        return stackView
    }()
    
    // MARK: - TableView Configuration
    
    // TableView for search result items
    private let searchResultTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // Register TableView and set self as it's delegate and datasource
    private func initializeTableView() {
        searchResultTableView.register(SearchedMoviesTableViewCell.self, forCellReuseIdentifier: SearchedMoviesTableViewCell.identifier)
        searchResultTableView.dataSource = self
        searchResultTableView.delegate = self
    }
    
 
    // MARK: - TableView Delegate Methods
    
    // Number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    // Cell configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchedMoviesTableViewCell.identifier) as! SearchedMoviesTableViewCell
        cell.initializeCellContent(filteredMovies[indexPath.row])
        return cell
    }
    
    // Cell Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    // Cell action
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let targetVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: DetailsViewController.identifier) as! DetailsViewController
        let selectedMovie = filteredMovies[indexPath.row]
        targetVC.movie = selectedMovie
        targetVC.genreIDs = selectedMovie.genreIDs
        self.navigationController?.present(targetVC, animated: true, completion: nil)
    }


    // MARK: - SearchBar Configuration and Delegate Methods
    
    private func initializeSearchBar() {
        searchBar.delegate = self
    }
    
    // SearchBar method that sends text input to initialize network call
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       // clear tableView cells if there is no text input
        guard searchText != ""  else {
            self.filteredMovies.removeAll()
            self.searchResultTableView.reloadData()
            return
        }
        NetworkEngine.request(endpoint: MoviesDbEndpoint.search(query: searchText)) { (result:Result<MoviesResponse, Error>) in
            switch result {
            case .success(let response):
                self.filteredMovies = response.results
                self.searchResultTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
    }

    
    // MARK: - Constraints
    
    private func initializeConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        let leadingSpace = CGFloat(24)
        let trailingSpace = CGFloat(-24)
        let paddingBetweenItems = CGFloat(10)
        let stackViewHeight = CGFloat(44)
        
        // SearchField
        constraints.append(searchBar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: trailingSpace))
        constraints.append(searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5))
        constraints.append(searchBar.heightAnchor.constraint(equalToConstant: stackViewHeight))
        constraints.append(searchBar.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7))
        
        // Favourite genre label
        constraints.append(favouriteGenreLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: leadingSpace))
        constraints.append(favouriteGenreLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: paddingBetweenItems))
        
        // Search result label
        constraints.append(searchResultLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: leadingSpace))
        constraints.append(searchResultLabel.topAnchor.constraint(equalTo: genreButtonsStackView.bottomAnchor, constant: paddingBetweenItems))
        
        // StackView for favourite genre buttons
        constraints.append(genreButtonsStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: leadingSpace))
        constraints.append(genreButtonsStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: trailingSpace))
        constraints.append(genreButtonsStackView.heightAnchor.constraint(equalToConstant: stackViewHeight))
        constraints.append(genreButtonsStackView.topAnchor.constraint(equalTo: favouriteGenreLabel.bottomAnchor, constant: paddingBetweenItems))
        
        // Searched movies tableView
        constraints.append(searchResultTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: leadingSpace))
        constraints.append(searchResultTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: trailingSpace))
        constraints.append(searchResultTableView.topAnchor.constraint(equalTo: searchResultLabel.bottomAnchor, constant: paddingBetweenItems))
        constraints.append(searchResultTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 5))
        

        NSLayoutConstraint.activate(constraints)
    }
}
