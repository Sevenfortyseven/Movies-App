//
//  UIView+RoundCorners.swift
//  Movies App
//
//  Created by aleksandre on 09.01.22.
//

import UIKit

// Rounded corners

extension UIView {
    
    
    public var roundedCorners: CGFloat? {
        get {
            let newCornerRadius = self.frame.size.width / 35
            self.layer.cornerRadius = newCornerRadius
            return nil
        }
    }
}

// Transform to a circle

extension UIView {
    
    public var transformToCircle: CGFloat? {
        get {
            let newCornerRadius = self.frame.size.width / 2
            self.layer.cornerRadius = newCornerRadius
            return nil
        }
    }
}
