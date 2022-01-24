//
//  SettingsSection.swift
//  Movies App
//
//  Created by aleksandre on 23.01.22.
//

import Foundation
import UIKit

class SettingsSection {
    
    var title: String
    var options: [String]
    var isOpened: Bool = false
    var icon: UIImage
    
    init(title: String, options: [String], isOpened: Bool = false, icon: UIImage) {
        self.title = title
        self.options = options
        self.isOpened = isOpened
        self.icon = icon
    }
}
