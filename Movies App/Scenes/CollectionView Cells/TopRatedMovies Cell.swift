//
//  TopRatedMovies Cell.swift
//  Movies App
//
//  Created by aleksandre on 10.01.22.
//

import Foundation
import UIKit

class TopRatedMoviesCollectionViewCell: UICollectionViewCell {
    
    private(set) static var identifier = "TopRatedMoviesCollectionViewCell"
    
    // MARK: - Instances
    
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .brown
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
