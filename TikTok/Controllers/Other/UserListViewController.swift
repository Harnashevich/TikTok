//
//  UserListViewController.swift
//  TikTok
//
//  Created by Andrei Harnashevich on 13.02.24.
//

import UIKit

class UserListViewController: UIViewController {
    
    enum ListType: String {
        case followers
        case following
    }
    
    let user: User
    let type: ListType
    
    // MARK: - Init

    init(type: ListType, user: User) {
        self.type = type
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

}
