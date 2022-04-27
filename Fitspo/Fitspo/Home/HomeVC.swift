//
//  HomeVC.swift
//  Fitspo
//
//  Created by Noah Yin on 4/17/22.
//

import UIKit

class HomeVC: UIPageViewController, UIScrollViewDelegate {

    var posts: [Post]?
    
    let refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Fetching New Posts ...", attributes: nil)
        refresh.tintColor = .fitOrange
        return refresh
    }()
    
    func reloadProfile(new: [Post]) {
        posts = new
        collectionView.reloadData()
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0 //was 50
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HomePostCell.self, forCellWithReuseIdentifier: HomePostCell.reuseIdentifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .systemBackground
        
        collectionView.addSubview(refreshControl)
        
        posts = DatabaseRequest.shared.getFeedPosts(vc: self)
        view.addSubview(collectionView)
        let tabbarHeight = self.tabBarController?.tabBar.frame.size.height
        collectionView.frame = view.bounds.inset(by: UIEdgeInsets(top: 40, left: 0, bottom: tabbarHeight!, right: 0))
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
        refreshControl.addTarget(self, action: #selector(refreshPage(_:)), for: .valueChanged)
    }
    
    @objc private func refreshPage(_ sender: Any) {
        posts = DatabaseRequest.shared.getFeedPosts(vc: self)
        self.refreshControl.endRefreshing()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.reloadInputViews()
//        posts = DatabaseRequest.shared.getFeedPosts(vc: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    

}

extension HomeVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
    UICollectionViewCell {
        let thisPost = posts?[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePostCell.reuseIdentifier, for: indexPath) as! HomePostCell
        cell.symbol = thisPost
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        return cell
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.width * 1.6)
    }
}
