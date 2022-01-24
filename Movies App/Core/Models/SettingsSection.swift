//
//  SettingsSection.swift
//  Movies App
//
//  Created by aleksandre on 23.01.22.
//

import Foundation

class SettingsSection {
    
    var title: String
    var options: [String]
    var isOpened: Bool = false
    
    init(title: String, options: [String], isOpened: Bool = false) {
        self.title = title
        self.options = options
        self.isOpened = isOpened
    }
}
