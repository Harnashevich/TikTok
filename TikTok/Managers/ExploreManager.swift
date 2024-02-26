//
//  ExploreManager.swift
//  TikTok
//
//  Created by Andrei Harnashevich on 26.02.24.
//

import UIKit

protocol ExploreManagerDelegate: AnyObject {
    /// Notify a view controller should be pushed
    /// - Parameter vc: The view controller to present
    func pushViewController(_ vc: UIViewController)
    /// Notify a hashtag element was tapped
    /// - Parameter hashtag: The hashtag taht was tapped
    func didTapHashtag(_ hashtag: String)
}

final class ExploreManager {
    
    static let shared = ExploreManager()
    
    weak var delegate: ExploreManagerDelegate?
    
    /// Represents banner action type
    enum BannerAction: String {
        /// Post type
        case post
        /// Hashtag search type
        case hashtag
        /// Creator type
        case user
    }
    
    public func getExploreBanners() -> [ExploreBannerViewModel] {
        guard let exploreData = parseExploreData() else {
            return []
        }
        
        return exploreData.banners.compactMap{ model in
            ExploreBannerViewModel(
                image: UIImage(named: model.image),
                title: model.title
            ) { [weak self] in
                guard
                    let self,
                    let action = BannerAction(rawValue: model.action) else {
                    return
                }
                DispatchQueue.main.async {
                    let vc = UIViewController()
                    vc.view.backgroundColor = .systemBackground
                    vc.title = action.rawValue.uppercased()
                    self.delegate?.pushViewController(vc)
                }
            }
        }
    }
    
    public func getExploreCreators() -> [ExploreUserViewModel] {
        guard let exploreData = parseExploreData() else {
            return []
        }

        return exploreData.creators.compactMap{ model in
            ExploreUserViewModel(
                profilePicture: UIImage(named: model.image),
                username: model.username,
                followerCuunt: model.followers_count
            ) { [weak self] in
                guard let self else { return }
                DispatchQueue.main.async {
                    let userId = model.id
                    // Fetch user object from firebase
                    let vc = ProfileViewController(user: User(username: "joe", profilePictureURL: nil, identifier: userId))
                    self.delegate?.pushViewController(vc)
                }
            }
        }
    }
    
    public func getExploreHashtags() -> [ExploreHashtagViewModel] {
        guard let exploreData = parseExploreData() else {
            return []
        }
        
        return exploreData.hashtags.compactMap{ model in
            ExploreHashtagViewModel(
                text: "#" + model.tag,
                icon: UIImage(systemName: model.image),
                count: model.count
            ) { [weak self] in
                guard let self else { return }
                DispatchQueue.main.async {
                    self.delegate?.didTapHashtag(model.tag)
                }
            }
        }
    }
    
    public func getExploreTrendingPosts() -> [ExplorePostViewModel] {
        guard let exploreData = parseExploreData() else {
            return []
        }
        
        return exploreData.trendingPosts.compactMap{ model in
            ExplorePostViewModel(
                thumbnailImage: UIImage(named: model.image),
                caption: model.caption
            ) { [weak self] in
                guard let self else { return }
                DispatchQueue.main.async {
                    // use id to fetch post from firebase
                    let postID = model.id
                    let vc = PostViewController(model: PostModel(identifier: postID))
                    self.delegate?.pushViewController(vc)
                }
            }
        }
    }
    
    public func getExploreRecentPosts() -> [ExplorePostViewModel] {
        guard let exploreData = parseExploreData() else {
            return []
        }
        
        return exploreData.recentPosts.compactMap{ model in
            ExplorePostViewModel(
                thumbnailImage: UIImage(named: model.image),
                caption: model.caption
            ) {[weak self] in
                guard let self else { return }
                DispatchQueue.main.async {
                    // use id to fetch post from firebase
                    let postID = model.id
                    let vc = PostViewController(model: PostModel(identifier: postID))
                    self.delegate?.pushViewController(vc)
                }
            }
        }
    }
    
    public func getExplorePopularPosts() -> [ExplorePostViewModel] {
        guard let exploreData = parseExploreData() else {
            return []
        }
        
        return exploreData.popular.compactMap{ model in
            ExplorePostViewModel(
                thumbnailImage: UIImage(named: model.image),
                caption: model.caption
            ) { [weak self] in
                guard let self else { return }
                DispatchQueue.main.async {
                    // use id to fetch post from firebase
                    let postID = model.id
                    let vc = PostViewController(model: PostModel(identifier: postID))
                    self.delegate?.pushViewController(vc)
                }
            }
        }
                                               }
                                               
    // MARK: - Private
    
    private func parseExploreData() -> ExploreResponse? {
        guard let path = Bundle.main.path(forResource: "explore", ofType: "json") else {
            return nil
        }

        do {
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(
                ExploreResponse.self,
                from: data
            )
        } catch {
            print(error)
            return nil
        }
    }
}
