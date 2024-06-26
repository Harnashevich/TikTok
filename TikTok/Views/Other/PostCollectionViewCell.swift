//
//  PostCollectionViewCell.swift
//  TikTok
//
//  Created by Andrei Harnashevich on 14.03.24.
//

import AVFoundation
import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    static let identifer = "PostCollectionViewCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        contentView.addSubview(imageView)
        contentView.backgroundColor = .secondarySystemBackground
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configure(with post: PostModel) {
        StorageManager.shared.getDownloadURL(for: post) { result in
            DispatchQueue.global().async {
                switch result {
                case .success(let url):
                    print("got url: \(url)")
                    
                    let asset = AVAsset(url: url)
                    let generator = AVAssetImageGenerator(asset: asset)
                    
                    do {
                        let cgImage = try generator.copyCGImage(at: .zero, actualTime: nil)
                        
                        DispatchQueue.main.async {
                            self.imageView.image = UIImage(cgImage: cgImage)
                        }
                        
                    } catch {
                        
                    }
                case .failure(let error):
                    print("failed to get download url: \(error)")
                }
            }
        }
    }
}
