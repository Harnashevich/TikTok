//
//  ExploreHashtagViewModel.swift
//  TikTok
//
//  Created by Andrei Harnashevich on 22.02.24.
//

import UIKit

struct ExploreHashtagViewModel {
    let text: String
    let icon: UIImage?
    let count: Int // number of posts associated with tag
    let handler: (() -> Void)
}
