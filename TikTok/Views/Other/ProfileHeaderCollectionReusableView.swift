//
//  ProfileHeaderCollectionReusableView.swift
//  TikTok
//
//  Created by Andrei Harnashevich on 5.03.24.
//

import SDWebImage
import UIKit

protocol ProfileHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderCollectionReusableView(_ header: ProfileHeaderCollectionReusableView,
                                             didTapPrimaryButtonWith viewModel: ProfileHeaderViewModel)
    func profileHeaderCollectionReusableView(_ header: ProfileHeaderCollectionReusableView,
                                             didTapFollowersWith viewModel: ProfileHeaderViewModel)
    func profileHeaderCollectionReusableView(_ header: ProfileHeaderCollectionReusableView,
                                             didTapFollowingButtonWith viewModel: ProfileHeaderViewModel)
    func profileHeaderCollectionReusableView(_ header: ProfileHeaderCollectionReusableView,
                                             didTapAvatarFor viewModel: ProfileHeaderViewModel)
}

class ProfileHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileHeaderCollectionReusableView"

    weak var delegate: ProfileHeaderCollectionReusableViewDelegate?

    var viewModel: ProfileHeaderViewModel?

    // Subviews

    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()

    // Follow or Edit Profile
    private let primaryButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.setTitleColor(.label, for: .normal)
        button.layer.masksToBounds = true
        button.setTitle("Follow", for: .normal)
        button.backgroundColor = .systemPink
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        return button
    }()

    private let followersButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.setTitle("0\nFollowers", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 2
        button.backgroundColor = .secondarySystemBackground
        return button
    }()

    private let followingButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.setTitleColor(.label, for: .normal)
        button.layer.masksToBounds = true
        button.setTitle("0\nFollowing", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 2
        button.backgroundColor = .secondarySystemBackground
        return button
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        backgroundColor = .systemBackground
        addSubviews()
        configureButtons()

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapAvatar))
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tap)
    }

    @objc func didTapAvatar() {
        guard let viewModel = viewModel else {
            return
        }
        delegate?.profileHeaderCollectionReusableView(
            self,
            didTapAvatarFor: viewModel
        )
    }

    func addSubviews() {
        addSubview(avatarImageView)
        addSubview(primaryButton)
        addSubview(followersButton)
        addSubview(followingButton)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func configureButtons() {
        primaryButton.addTarget(self, action: #selector(didTapPrimaryButton), for: .touchUpInside)
        followersButton.addTarget(self, action: #selector(didTapFollowersButton), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let avatarSize: CGFloat = 130
        avatarImageView.frame = CGRect(x: (width - avatarSize)/2, y: 5, width: avatarSize, height: avatarSize)
        avatarImageView.layer.cornerRadius = avatarImageView.height/2

        followersButton.frame = CGRect(x: (width - 210)/2, y: avatarImageView.bottom+10, width: 100, height: 60)
        followingButton.frame = CGRect(x: followersButton.right + 10, y: avatarImageView.bottom+10, width: 100, height: 60)

        primaryButton.frame = CGRect(x: (width - 220)/2, y: followingButton.bottom+15, width: 220, height: 44)
    }

    // Actions

    @objc func didTapPrimaryButton() {
        guard let viewModel = self.viewModel else {
            return
        }
        delegate?.profileHeaderCollectionReusableView(self,
                                                      didTapPrimaryButtonWith: viewModel)
    }

    @objc func didTapFollowersButton() {
        guard let viewModel = self.viewModel else {
            return
        }
        delegate?.profileHeaderCollectionReusableView(self,
                                                      didTapFollowersWith: viewModel)
    }

    @objc func didTapFollowingButton() {
        guard let viewModel = self.viewModel else {
            return
        }
        delegate?.profileHeaderCollectionReusableView(self,
                                                      didTapFollowingButtonWith: viewModel)
    }

    func configure(with viewModel: ProfileHeaderViewModel) {
        self.viewModel = viewModel
        // Set up our header
        followersButton.setTitle("\(viewModel.followerCount)\nFollowers", for: .normal)
        followingButton.setTitle("\(viewModel.followingCount)\nFollowing", for: .normal)
        if let avatarURL = viewModel.avatarImageURL {
            avatarImageView.sd_setImage(with: avatarURL, completed: nil)
        } else {
            avatarImageView.image = UIImage(named: "test")
        }

        if let isFollowing = viewModel.isFollowing {
            primaryButton.backgroundColor = isFollowing ? .secondarySystemBackground : .systemPink
            primaryButton.setTitle(isFollowing ? "Unfollow" : "Follow", for: .normal)
        } else {
            primaryButton.backgroundColor = .secondarySystemBackground
            primaryButton.setTitle("Edit Profile", for: .normal)
        }
    }
}
