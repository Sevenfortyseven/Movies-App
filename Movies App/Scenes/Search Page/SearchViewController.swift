//
//  SearchViewController.swift
//  Movies App
//
//  Created by aleksandre on 15.01.22.
//

import UIKit

class SearchViewController: UIViewController {
    private(set) static var identifier = "SearchViewController"
    
    // MARK: - Instances
    
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: - Content View
    
    
    // MARK: - UI Config
    
    private func updateUI() {
        self.view.backgroundColor = .mainAppColor
    }
    
    // MARK: - Constraints
}
