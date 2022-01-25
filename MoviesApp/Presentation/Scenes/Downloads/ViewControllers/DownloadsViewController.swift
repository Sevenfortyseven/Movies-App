//
//  DownloadsViewController.swift
//  Movies App
//
//  Created by aleksandre on 25.01.22.
//

import Foundation
import UIKit


class DownloadsViewController: UIViewController {
    
    // Self identifier
    private(set) static var identifier = "DownloadsViewController"
    
    
    // MARK: - Instances
    
    
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
    }
    
    private func setupConstraints() {
        comingSoonLabel.frame = CGRect(x: self.view.frame.height / 2, y: self.view.frame.width / 2, width: 300, height: 60)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateTheme()
    }
 
    
    private func addSubviews() {
        self.view.addSubview(comingSoonLabel)
    }
    
    
    // MARK: - UI Configuration
    

    private func updateTheme() {
        let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        if isDarkMode {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
        self.view.backgroundColor = .primaryColor
      
    }


    // MARK: - UI Elements
    
    private let comingSoonLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.text = "Coming Soon"
        label.textColor = .appRedColor
        return label
    }()
}
