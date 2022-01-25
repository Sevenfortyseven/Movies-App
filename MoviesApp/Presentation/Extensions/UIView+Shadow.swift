//
//  UIView+Shadow.swift
//  Movies App
//
//  Created by aleksandre on 20.01.22.
//

import Foundation
import UIKit

// Adds shadow to the layer of the view

extension UIView {
    
    func dropShadow(color: CGColor) {
        layer.masksToBounds = false
        layer.shadowColor = color
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer .shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
    }
    
}
