//
//  SwitchCellViewModel.swift
//  TikTok
//
//  Created by Andrei Harnashevich on 15.03.24.
//

import Foundation

struct SwitchCellViewModel {
    let title: String
    var isOn: Bool

    mutating func setOn(_ on: Bool) {
        self.isOn = on
    }
}
