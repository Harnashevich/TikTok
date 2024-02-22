//
//  ExploreCell.swift
//  TikTok
//
//  Created by Andrei Harnashevich on 22.02.24.
//

enum ExploreCell {
    case banner(viewModel: ExploreBannerViewModel)
    case post(viewModel: String)
    case hashtag(viewModel: String)
    case user(viewModel: String)
}
