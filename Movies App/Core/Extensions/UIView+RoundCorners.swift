//
//  UIView+RoundCorners.swift
//  Movies App
//
//  Created by aleksandre on 09.01.22.
//

import UIKit

// Rounded corners

extension UIView {
    
    
    public var roundedCornersMinCurve: CGFloat? {
        get {
            let newCornerRadius = self.frame.size.width / 35
            self.layer.cornerRadius = newCornerRadius
            return nil
        }
    }
    
    public var roundedCornersMediumCurve: CGFloat? {
        get {
            let newCornerRadius = self.frame.size.width / 25
            self.layer.cornerRadius = newCornerRadius
            return nil
        }
    }
    
    public var roundedCornersMaxCurve: CGFloat? {
        get {
            let newCornerRadius = self.frame.size.width / 15
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
