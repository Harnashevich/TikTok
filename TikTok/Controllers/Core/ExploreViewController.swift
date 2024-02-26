//
//  ExploreViewController.swift
//  TikTok
//
//  Created by Andrei Harnashevich on 13.02.24.
//

import UIKit

class ExploreViewController: UIViewController {
    
    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search..."
        bar.layer.cornerRadius = 8
        bar.layer.masksToBounds = true
        return bar
    }()
    
    private var sections = [ExploreSection]()
    
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureModels()
        setUpSearchBar()
        setUpCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    private func setUpSearchBar() {
        navigationItem.titleView = searchBar
        searchBar.delegate = self
    }
    
    private func configureModels() {
        var cells = [ExploreCell]()
        for _ in 0...1000 {
            let cell = ExploreCell.banner(viewModel: ExploreBannerViewModel(
                image: UIImage(named: "test"),
                title: "Foo",
                handler: {
                    
                }
            )
            )
            cells.append(cell)
        }
        
        // Banners
        sections.append(
            ExploreSection(
                type: .banners,
                cells: cells
            )
        )
        
        // Trending posts
        
        var posts = [ExploreCell]()
        for _ in 0...40 {
            posts.append(ExploreCell.post(viewModel: ExplorePostViewModel(thumbnailImage: UIImage(named: "test"), caption: "This is a really cool post and a long caption", handler: {})))
        }
        
        sections.append(
            ExploreSection(
                type: .trendingPosts,
                cells: posts
            )
        )
        
        // Users
        
        sections.append(
            ExploreSection(
                type: .users,
                cells: [
                    .user(viewModel: ExploreUserViewModel(profilePicture: UIImage(named: "test"), username: "Kanye", followerCuunt: 0, handler: {})),
                    .user(viewModel: ExploreUserViewModel(profilePicture: UIImage(named: "test"), username: "Andrei", followerCuunt: 0, handler: {})),
                    .user(viewModel: ExploreUserViewModel(profilePicture: UIImage(named: "test"), username: "Foo", followerCuunt: 0, handler: {})),
                    .user(viewModel: ExploreUserViewModel(profilePicture: UIImage(named: "test"), username: "Man", followerCuunt: 0, handler: {}))
                ]
            )
        )
        
        // Trending hashtags
        
        sections.append(
            ExploreSection(
                type: .trendingHashtags,
                cells: [
                    .hashtag(viewModel: ExploreHashtagViewModel(text: "#foryou", icon: UIImage(named: "test"), count: 0, handler: {})),
                    .hashtag(viewModel: ExploreHashtagViewModel(text: "#foryou", icon: UIImage(named: "test"), count: 0, handler: {})),
                    .hashtag(viewModel: ExploreHashtagViewModel(text: "#foryou", icon: UIImage(named: "test"), count: 0, handler: {})),
                ]
            )
        )
        
        // Recommended
        
        sections.append(
            ExploreSection(
                type: .recommended,
                cells: [
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: UIImage(named: "test"), caption: "", handler: {})),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: UIImage(named: "test"), caption: "", handler: {})),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: UIImage(named: "test"), caption: "", handler: {})),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: UIImage(named: "test"), caption: "", handler: {}))
                ]
            )
        )
        
        // Popular
        
        sections.append(
            ExploreSection(
                type: .popular,
                cells: [
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: UIImage(named: "test"), caption: "", handler: {})),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: UIImage(named: "test"), caption: "", handler: {})),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: UIImage(named: "test"), caption: "", handler: {})),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: UIImage(named: "test"), caption: "", handler: {}))
                ]
            )
        )
        
        // New/recent
        
        sections.append(
            ExploreSection(
                type: .new,
                cells: [
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: UIImage(named: "test"), caption: "", handler: {})),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: UIImage(named: "test"), caption: "", handler: {})),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: UIImage(named: "test"), caption: "", handler: {})),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: UIImage(named: "test"), caption: "", handler: {}))
                ]
            )
        )
    }
    
    private func setUpCollectionView() {
        let layout = UICollectionViewCompositionalLayout { section, _ -> NSCollectionLayoutSection? in
            return self.layout(for: section)
        }
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: "cell"
        )
        
        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: "cell"
        )
        collectionView.register(
            ExploreBannerCollectionViewCell.self,
            forCellWithReuseIdentifier: ExploreBannerCollectionViewCell.identifier
        )
        collectionView.register(
            ExplorePostCollectionViewCell.self,
            forCellWithReuseIdentifier: ExplorePostCollectionViewCell.identifier
        )
        collectionView.register(
            ExploreUserCollectionViewCell.self,
            forCellWithReuseIdentifier: ExploreUserCollectionViewCell.identifier
        )
        collectionView.register(
            ExploreHashtagCollectionViewCell.self,
            forCellWithReuseIdentifier: ExploreHashtagCollectionViewCell.identifier
        )
        
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        self.collectionView = collectionView
    }
}

extension ExploreViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = sections[indexPath.section].cells[indexPath.row]
        
        switch model {
            
        case .banner(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ExploreBannerCollectionViewCell.identifier,
                for: indexPath
            ) as? ExploreBannerCollectionViewCell else {
                return collectionView.dequeueReusableCell(
                    withReuseIdentifier: "cell",
                    for: indexPath
                )
            }
            cell.configure(with: viewModel)
            return cell
        case .post(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ExplorePostCollectionViewCell.identifier,
                for: indexPath
            ) as? ExplorePostCollectionViewCell else {
                return collectionView.dequeueReusableCell(
                    withReuseIdentifier: "cell",
                    for: indexPath
                )
            }
            cell.configure(with: viewModel)
            return cell
        case .hashtag(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ExploreHashtagCollectionViewCell.identifier,
                for: indexPath
            ) as? ExploreHashtagCollectionViewCell else {
                return collectionView.dequeueReusableCell(
                    withReuseIdentifier: "cell",
                    for: indexPath
                )
            }
            cell.configure(with: viewModel)
            return cell
        case .user(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ExploreUserCollectionViewCell.identifier,
                for: indexPath
            ) as? ExploreUserCollectionViewCell else {
                return collectionView.dequeueReusableCell(
                    withReuseIdentifier: "cell",
                    for: indexPath
                )
            }
            cell.configure(with: viewModel)
            return cell
        }
    }
}

extension ExploreViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        HapticsManager.shared.vibrateForSelection()
        let model = sections[indexPath.section].cells[indexPath.row]

        switch model {
        case .banner(let viewModel):
            viewModel.handler()
        case .post(let viewModel):
            viewModel.handler()
        case .hashtag(let viewModel):
            viewModel.handler()
        case .user(let viewModel):
            viewModel.handler()
        }
    }
}

extension ExploreViewController: UISearchBarDelegate {
    
}

// MARK: - Section Layouts

extension ExploreViewController {
    
    func layout(for section: Int) -> NSCollectionLayoutSection {
        let sectionType = sections[section].type
        
        switch sectionType {
        case .banners:
            // Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
            
            // Group
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .absolute(200)
                ),
                subitems: [item]
            )
            
            // Section layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .groupPaging
            // Return
            return sectionLayout
        case .users:
            // Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
            
            // Group
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(150),
                    heightDimension: .absolute(200)
                ),
                subitems: [item]
            )
            
            // Section layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .continuous
            // Return
            return sectionLayout
            
        case .trendingHashtags:
            // Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
            
            // Group
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(60)
                ),
                subitems: [item]
            )
            
            // Section layout
            let sectionLayout = NSCollectionLayoutSection(group: verticalGroup)
            
            // Return
            return sectionLayout
            
        case .trendingPosts, .new, .recommended:
            // Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
            
            // Group
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(100),
                    heightDimension: .absolute(300)
                ),
                subitem: item,
                count: 2
            )
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(110),
                    heightDimension: .absolute(300)
                ),
                subitems: [verticalGroup]
            )
            
            // Section layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .continuous
            // Return
            return sectionLayout
            
        case .popular:
            // Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(110),
                    heightDimension: .absolute(200)
                ),
                subitems: [item]
            )
            
            // Section layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .continuous
            // Return
            return sectionLayout
        }
    }
}
