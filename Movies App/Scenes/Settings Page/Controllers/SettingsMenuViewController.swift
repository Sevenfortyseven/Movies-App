//
//  SettingsMenuViewController.swift
//  Movies App
//
//  Created by aleksandre on 23.01.22.
//

import UIKit
import SideMenu

class SettingsMenuViewController: UIViewController, Menu {
    
    
    var menuItems: [UIView] = []
    
    // Self identifier
    private(set) static var identifier = "ColorsThemeViewController"
    
    
    // MARK: - Instances
    
    
    // MARK: - Initialization
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    
    // MARK: - UI Configuration
    
    private func updateUI() {
        self.view.backgroundColor = .mainAppColor
    }
    
    private func updateFrames() {
        
    }
    
    // MARK: - UI Elements
    
    

    
    
}
