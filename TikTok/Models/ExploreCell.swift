//
//  ExploreCell.swift
//  TikTok
//
//  Created by Andrei Harnashevich on 22.02.24.
//

enum ExploreCell {
    case banner(viewModel: ExploreBannerViewModel)
    case post(viewModel: ExplorePostViewModel)
    case hashtag(viewModel: ExploreHashtagViewModel)
    case user(viewModel: ExploreUserViewModel)
}
