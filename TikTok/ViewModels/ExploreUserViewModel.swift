//
//  ExploreUserViewModel.swift
//  TikTok
//
//  Created by Andrei Harnashevich on 22.02.24.
//

import UIKit

struct ExploreUserViewModel {
    let profilePicture: UIImage?
    let username: String
    let followerCuunt: Int
    let handler: (() -> Void)
}
