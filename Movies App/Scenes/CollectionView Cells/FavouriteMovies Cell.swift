//
//  FavouriteMovies Cell.swift
//  Movies App
//
//  Created by aleksandre on 20.01.22.
//

import Foundation
import UIKit

class FavouriteMoviesCollectionViewCell: UICollectionViewCell {

    private(set) static var identifier = "FavouriteMoviesCollectionViewCell"
    
    
    //MARK: - Instances
    

    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        initializeConstraints()
        updateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateFrames()
    }
    
    //Add subviews
    private func addSubviews() {
        
    }
    
    public func initializeContentView() {
        
    }
    
    //MARK: - UI configuration
    private func updateUI() {
        self.backgroundColor = .yellow
        movieBackdrop.frame = self.contentView.bounds
    }
    
    private func updateFrames() {
        
    }
    
    
    //MARK: - UI Elements
    
    private let movieBackdrop: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()

    
    
    //MARK: - Constraints
    
    private func initializeConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
}
