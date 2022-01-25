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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateTheme()
    }
 
    
    private func addSubviews() {
        self.view.addSubview(tmpLabel)
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
    
    private let tmpLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 200, y: 200, width: 300, height: 60))
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.text = "Coming Soon"
        label.textColor = .appRedColor
        return label
    }()
}
