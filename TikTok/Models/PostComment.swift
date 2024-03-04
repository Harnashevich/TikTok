//
//  PostComment.swift
//  TikTok
//
//  Created by Andrei Harnashevich on 19.02.24.
//

import Foundation

struct PostComment {
    let text: String
    let user: User
    let date: Date

    static func mockCommets() -> [PostComment] {
        let user = User(
            username: "kanyewest",
            profilePictureURL: nil,
            identifier: UUID().uuidString
        )
        var comments = [PostComment]()

        let text = [
            "This is cool",
            "This is rad",
            "Im learning so muchdslkjjdsjfkdsjfhdhsjkfjkhdsjkhfkdhkjshjkfhkj   !"
        ]

        for comment in text {
            comments.append(
                PostComment(
                    text: comment,
                    user: user,
                    date: Date()
                )
            )
        }
        
        return comments
    }
}
