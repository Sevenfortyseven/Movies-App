//
//  UIColor+Extension.swift
//  Movies App
//
//  Created by aleksandre on 25.12.21.
//

import UIKit

extension UIColor {
    
    // Main App Color
    static var mainAppColor: UIColor {
        
        get {
            self.init(red: 0.10, green: 0.10, blue: 0.10, alpha: 1)
        }
    }
    
    static var tabBarColor: UIColor {
        
        get {
            self.init(red: 0.03, green: 0.03, blue: 0.03, alpha: 0.8)
        }
    }
    
    static var appRedColor: UIColor {
        
        get {
            self.init(red: 0.8, green: 0.09, blue: 0.2, alpha: 1)
        }
    }
    
    static var appDarkRedColor: UIColor {
        
        get {
            self.init(red: 0.6, green: 0.09, blue: 0.2, alpha: 1)
        }
    }
    
    
    
}
