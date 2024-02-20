//
//  ProfileViewController.swift
//  TikTok
//
//  Created by Andrei Harnashevich on 13.02.24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var user: User
    
    // MARK: - Init

    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = user.username.uppercased()
        view.backgroundColor = .systemBackground
    }
}
