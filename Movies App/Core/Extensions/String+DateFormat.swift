//
//  String+DateFormat.swift
//  Movies App
//
//  Created by aleksandre on 09.01.22.
//

import Foundation

// Change date format of the string to show only year

extension String {
    
    var YearFormat: String? {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let date = dateFormatter.date(from: self) {
                dateFormatter.dateFormat = "YYYY"
                return dateFormatter.string(from: date)
            }
            return nil
        }
        
    }
    
}
