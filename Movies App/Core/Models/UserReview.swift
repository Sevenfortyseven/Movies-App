//
//  UserReview.swift
//  Movies App
//
//  Created by aleksandre on 19.01.22.
//

import Foundation

struct UserReview: Codable {

    let author: String
    let content: String
    let createdAt: String
    let id: String
    let url: String
    let authorDetails: AuthorDetails

    enum CodingKeys: String, CodingKey {
        case author, content, id, url
        case createdAt = "created_at"
        case authorDetails = "author_details"
    }

}
struct AuthorDetails: Codable {

    let username: String
    let avatarPath: String?
    let rating: Int?
    let name: String

    enum CodingKeys: String, CodingKey {
        case username, rating, name
        case avatarPath = "avatar_path"
    }

}
