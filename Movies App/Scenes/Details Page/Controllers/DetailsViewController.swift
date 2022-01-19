//
//  DetailsPageController.swift
//  Movies App
//
//  Created by aleksandre on 11.01.22.
//

import Foundation
import UIKit
import WebKit

class DetailsViewController: UIViewController, WKNavigationDelegate {
    
    // Self identifier
    private(set) static var identifier = "DetailsViewController"
    
    // MARK: - IBOutlets
    
    // MARK: - Instances
    
    public var movieID: Int?
    private var video = [Video]()

    
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        initializeConstraints()
        networkInAction()
        updateUI()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        spinner.startAnimating()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateFrames()

     
    }
    
    // Populate view with subviews
    private func addSubviews() {
        self.view.addSubview(webView)
        self.view.addSubview(spinner)
    }
    

    // MARK: - Content View
    
    //AVplayer view
    private let webView: WKWebView = {
        var webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.isOpaque = false
        return webView
    }()
    
    // Activity indicator
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.style = .large
        return spinner
    }()
    
    
    // MARK: - UI Config
    
    private func updateUI() {
        self.view.backgroundColor = .mainAppColor


    }
    
    // Update frames
    
    private func updateFrames() {
        spinner.center = webView.center
    }
    
    // MARK: - WebView Configuration and Delegate Methods
    
    
    // Initialize webView content
    private func initializeWebView() {
        webView.navigationDelegate = self
        let YTkey = video[0].key
        let embedURL = StaticEndpoint.YTendpoint + YTkey
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

    
    
    // MARK: - Networking
    
    private func networkInAction() {
        guard movieID != nil else {
            print("movie id not available")
            return
        }
        // Network request to get YT video key
        NetworkEngine.request(endpoint: MoviesDbEndpoint.movieTrailer(movieID: movieID!)) { (result: Result<VideosResponse, Error>) in
            switch result {
            case .success(let response):
                self.video = response.results
                self.initializeWebView()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Constraints
    
    private func initializeConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        //AVplayer view
        constraints.append(webView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0))
        constraints.append(webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0))
        constraints.append(webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0))
        constraints.append(webView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3))
        
        
        // Spinner View
        constraints.append(spinner.centerXAnchor.constraint(equalTo: webView.centerXAnchor))
        constraints.append(spinner.centerYAnchor.constraint(equalTo: webView.centerYAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
}
