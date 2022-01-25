//
//  ColorThemeSettings Cell.swift
//  Movies App
//
//  Created by aleksandre on 23.01.22.
//

import Foundation
import UIKit

class SettingsSectionTableViewCell: UITableViewCell {
    
    private(set) static var identifier = "ColorThemeSettingsTableViewCell"
    

    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: SettingsSectionTableViewCell.identifier)
        updateUI()
        addSubviews()
        initializeConstraints()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateFrames()
        updateTheme()
        
    }
    
    private func addSubviews() {
        self.contentView.addSubview(optionCellIcon)
        self.contentView.addSubview(optionCellTitle)
    }
    
    
    // MARK: - UI Configuration
    
    private func updateUI() {
        self.backgroundColor = .clear
        updateTheme()
        
    }
    
    private func updateFrames() {
        optionCellTitle.frame = self.contentView.bounds
    }
    
    private func updateTheme() {
   
        DispatchQueue.main.async { [self] in
            let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
            if isDarkMode {
                overrideUserInterfaceStyle = .dark
                optionCellIcon.tintColor = .secondaryColor
            
            } else {
               overrideUserInterfaceStyle = .light
                optionCellIcon.tintColor = .lightGray
            }
            
        }
    }
    
    // MARK: - UI Elements
    
    // Title
    let optionCellTitle: UILabel = {
        let label = UILabel()
        label.textColor = .tertiaryColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let optionCellIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
}

// MARK: - Constraints

extension  SettingsSectionTableViewCell {
    
    private func initializeConstraints() {
        var constraints = [NSLayoutConstraint]()
        let optionCellIconSize = self.contentView.frame.size.width / 9
        
        // Icon
        constraints.append(optionCellIcon.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor))
        constraints.append(optionCellIcon.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 3 ))
        constraints.append(optionCellIcon.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -3))
        constraints.append(optionCellIcon.widthAnchor.constraint(equalToConstant: optionCellIconSize))
        
        // TitleView
        constraints.append(optionCellTitle.leadingAnchor.constraint(equalTo: optionCellIcon.trailingAnchor, constant: 5))
        constraints.append(optionCellTitle.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
}
