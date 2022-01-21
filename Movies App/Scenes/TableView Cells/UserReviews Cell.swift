//
//  UserReviews Cell.swift
//  Movies App
//
//  Created by aleksandre on 19.01.22.
//

import Foundation
import UIKit

class UserReviewsTableViewCell: UITableViewCell {
    
    // Self identifier
    private(set) static var identifier = "UserReviewsTableViewCell"
    
    // MARK: - Instances
    
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: UserReviewsTableViewCell.identifier)
        addSubviews()
        initializeConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUI()
        updateFrames()
   

    }
    
    
    
    // Add subviews
    private func addSubviews() {
        self.contentView.addSubview(userAvatarView)
        self.contentView.addSubview(userNicknameView)
        self.contentView.addSubview(userReviewView)
    }
    
    // ContentView initialization
    public func initializeContentView(_ userReview: UserReview) {
        /// ImageView initialization
        guard let avatarPath = userReview.authorDetails.avatarPath else {
            print("No avatar available")
            return
        }
        let url = StaticEndpoint.remoteImagesEndpoint + avatarPath
        self.userAvatarView.loadImageFromUrl(urlString: url, placeHolder: UIImage(named: "no_image"))
        
        /// User nickname initialization
        self.userNicknameView.text = userReview.authorDetails.username
        /// User review initialization
        self.userReviewView.text = userReview.content
        
    }
    
    // MARK: - Content View Elements
    
    //User avatar View
    private let userAvatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    //User nickname
    private let userNicknameView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .callout, compatibleWith: .init(legibilityWeight: .bold))
        return label
    }()
    
    //User review
    private let userReviewView: UITextView = {
        let textView = UITextView()
        textView.textColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        return textView
    }()
    
    // MARK: - UI Configuration
    
    private func updateUI() {
        self.backgroundColor = .mainAppColor
        
    }
    
    // Update frames
    private func updateFrames() {
        userAvatarView.layoutIfNeeded()
        _ = userAvatarView.transformToCircle
    }
    
    // MARK: - Constraints
    
    private func initializeConstraints() {
        var constraints = [NSLayoutConstraint]()
        let leadingPadding = CGFloat(5)
        let topPadding = CGFloat(5)
        let trailingPadding = CGFloat(5)
        let bottomPadding = CGFloat(-15)
        let paddingBetweenViews = CGFloat(5)
        let avatarSize = CGFloat(60)
        
        //User avatar view
        constraints.append(userAvatarView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: leadingPadding))
        constraints.append(userAvatarView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: topPadding))
        constraints.append(userAvatarView.widthAnchor.constraint(equalToConstant: avatarSize))
        constraints.append(userAvatarView.heightAnchor.constraint(equalToConstant: avatarSize))
        
        //User nickname view
        constraints.append(userNicknameView.leadingAnchor.constraint(equalTo: userAvatarView.trailingAnchor, constant: paddingBetweenViews))
        constraints.append(userNicknameView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: topPadding))
        
        //User review
        constraints.append(userReviewView.leadingAnchor.constraint(equalTo: userAvatarView.trailingAnchor, constant: paddingBetweenViews))
        constraints.append(userReviewView.topAnchor.constraint(equalTo: userNicknameView.bottomAnchor, constant: paddingBetweenViews))
        constraints.append(userReviewView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: trailingPadding))
        constraints.append(userReviewView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: bottomPadding))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
}
