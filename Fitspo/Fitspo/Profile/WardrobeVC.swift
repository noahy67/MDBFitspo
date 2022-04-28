//
//  WardrobeVC.swift
//  Fitspo
//
//  Created by Noah Yin on 4/27/22.
//

import UIKit
import NotificationBannerSwift
import Firebase
import SwiftUI

class WardrobeVC: UIViewController {
    
    var wardrobe: [WardrobeItem]?
    
    let creatorURL = AuthManager.shared.currentUser?.uid
    
    func reloadWardrobe(new: [WardrobeItem]) {
        wardrobe = new
        collectionView.reloadData()
    }

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 50
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(WardrobeCell.self, forCellWithReuseIdentifier: WardrobeCell.reuseIdentifier)
        return collectionView
    }()
    
    private let backButton: UIButton = {
        let btn = UIButton()
        btn.setTitle(" Back ", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .fitOrange
        btn.layer.cornerRadius = 10
        btn.layer.shadowRadius = 10
        btn.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        wardrobe = DatabaseRequest.shared.getWardrobeItems(vc: self, creatorURL: creatorURL!)
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .fitCream
        collectionView.frame = view.bounds.inset(by: UIEdgeInsets(top: 300, left: 10, bottom: 100, right: 10))
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
            ])
        
        backButton.addTarget(self, action: #selector(didTapBackButton(_:)), for: .touchUpInside)
        collectionView.reloadData()
    }
    
    @objc func didTapBackButton(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.reloadInputViews()
//        guard let creatorURL = AuthManager.shared.currentUser?.uid else { return }
//        wardrobe = DatabaseRequest.shared.getWardrobeItems(vc: self, creatorURL: creatorURL)
//    }

}

extension WardrobeVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wardrobe?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
    UICollectionViewCell {
        let thisWI = wardrobe?[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WardrobeCell.reuseIdentifier, for: indexPath) as! WardrobeCell
        cell.symbol = thisWI
        return cell
    }
}

extension WardrobeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
