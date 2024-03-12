//
//  PostModel.swift
//  TikTok
//
//  Created by Andrei Harnashevich on 15.02.24.
//

import Foundation

struct PostModel {
    let identifier: String
    let user: User
    var fileName: String = ""
    var caption: String = ""

    var isLikedByCurrentUser = false

    static func mockModels() -> [PostModel] {
        var posts = [PostModel]()
        for _ in 0...100 {
            let post = PostModel(
                identifier: UUID().uuidString,
                user: User(
                    username: "kanyewest",
                    profilePictureURL: nil,
                    identifier: UUID().uuidString
                )
            )
            posts.append(post)
        }
        return posts
    }

    /// Represents database child path for this post in a given user node
    var videoChildPath: String {
        return "videos/\(user.username.lowercased())/\(fileName)"
    }
}
