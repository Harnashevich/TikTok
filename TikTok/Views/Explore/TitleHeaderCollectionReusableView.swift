//
//  TitleHeaderCollectionReusableView.swift
//  TikTok
//
//  Created by Andrei Harnashevich on 26.02.24.
//

import UIKit

final class TitleHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "TitleHeaderCollectionReusableView"
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 5 , y: 0, width: width - 30, height: height)
    }
    
    required init? (coder: NSCoder) {
        fatalError()
    }
    
    func configure(with title: String) {
        label.text = title
    }
}
