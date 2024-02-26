//
//  ExploreResponse.swift
//  TikTok
//
//  Created by Andrei Harnashevich on 26.02.24.
//

struct ExploreResponse: Codable {
    let banners: [Banner]
    let trendingPosts: [Post]
    let creators: [Creator]
    let recentPosts: [Post]
    let hashtags: [Hashtag]
    let popular: [Post]
    let recommended: [Post]
}
