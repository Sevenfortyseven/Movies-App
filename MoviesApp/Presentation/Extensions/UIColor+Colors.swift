//
//  UIColor+Extension.swift
//  Movies App
//
//  Created by aleksandre on 25.12.21.
//

import UIKit


extension UIColor {
    

    static var primaryColor: UIColor {
        
        return self.init(named: "PrimaryColor")!
    }
    
    static var tabBarDark: UIColor {
        
        return self.init(named: "TabBarDark")!
    }
    
    static var tabBarLight: UIColor {
        
        return self.init(named: "TabBarLight")!
    }
    
    static var secondaryColor: UIColor {
        self.init(named: "SecondaryColor")!
    }

    
    static var tertiaryColor: UIColor {
        self.init(named: "TertiaryColor")!
    }
    
    static var appRedColor: UIColor {
        
        self.init(red: 0.8, green: 0.09, blue: 0.2, alpha: 1)
        
    }
    
    static var appDarkRedColor: UIColor {
        
        self.init(red: 0.6, green: 0.09, blue: 0.2, alpha: 1)
        
    }
    
}
