//
//  PostModel.swift
//  TikTok
//
//  Created by Andrei Harnashevich on 15.02.24.
//

import Foundation

struct PostModel {
    let identifier: String
    
    static func mockModels() -> [PostModel] {
        var posts = [PostModel]()
        for _ in 0...100 {
            let post = PostModel(identifier: UUID().uuidString)
            posts.append(post)
        }
        return posts
    }
}
