//
//  ViewController.swift
//  Movies App
//
//  Created by aleksandre on 25.12.21.
//

import UIKit

class HomeViewController: UIViewController {
    
    // Self identifier
    private(set) static var identifier = "HomeViewController"
    
    // MARK: - IBOutlets
    
    
    // MARK: - Instances
    
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        addSubViews()
        populateStackView()
        initializeConstraints()
        NetworkEngine.request(endpoint: MoviesDbEndpoint.dailyTrends) { (result: Result<MoviesResponse, Error>) in
            switch result {
            case .success(let response): print("Response: ", response)
            case .failure(let error): print(error)
            }
        }
    }
    
    
    // adding SubViews
    private func addSubViews() {
        self.view.addSubview(upperStackView)
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
        
        // NF logo

        
        NSLayoutConstraint.activate(constraints)
        
    }
}



