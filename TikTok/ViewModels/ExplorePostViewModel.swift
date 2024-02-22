//
//  ExplorePostViewModel.swift
//  TikTok
//
//  Created by Andrei Harnashevich on 22.02.24.
//

import UIKit

struct ExplorePostViewModel {
    let thumbnailImage: UIImage?
    let caption: String
    let handler: (() -> Void)
}
