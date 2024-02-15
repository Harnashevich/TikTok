//
//  PostViewController.swift
//  TikTok
//
//  Created by Andrei Harnashevich on 13.02.24.
//

import UIKit

class PostViewController: UIViewController {
    
    var model: PostModel
    
    // MARK: - Init

    init(model: PostModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colors: [UIColor] = [.red, .green, .black, .orange, .blue, .white, .systemPink]
        view.backgroundColor = colors.randomElement()
    }
}
