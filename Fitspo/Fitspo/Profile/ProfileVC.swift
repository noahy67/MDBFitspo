//
//  ProfileVC.swift
//  Fitspo
//
//  Created by Noah Yin on 4/17/22.
//

import UIKit
import NotificationBannerSwift
import Firebase
import SwiftUI

class ProfileVC: UIViewController {
    
    static let shared = ProfileVC()
    
    var posts: [Post]?
    
    func reloadProfile(new: [Post]) {
        posts = new
        collectionView.reloadData()
    }
    
    let storage = Storage.storage()
    let tempImage: UIImage = UIImage(named: "no-profile-image")!
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 50
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProfilePostCell.self, forCellWithReuseIdentifier: ProfilePostCell.reuseIdentifier)
        return collectionView
    }()
    
    private let settingsButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "gearshape")?.withTintColor(.fitOrange, renderingMode: .alwaysOriginal), for: .normal)
        btn.backgroundColor = .clear
        btn.layer.cornerRadius = 10
        btn.layer.shadowRadius = 10
        btn.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.contentVerticalAlignment = .fill
        btn.contentHorizontalAlignment = .fill
        return btn
    }()
    
    private let createPostButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "plus.app")?.withTintColor(.fitOrange, renderingMode: .alwaysOriginal), for: .normal)
        btn.backgroundColor = .clear
        btn.layer.cornerRadius = 10
        btn.layer.shadowRadius = 10
        btn.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.contentVerticalAlignment = .fill
        btn.contentHorizontalAlignment = .fill
//        btn.imageEdgeInsets = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        return btn
    }()
    
    private let usernameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "username"
        lbl.font = UIFont(name: "ReemKufi", size: 35)
        lbl.textColor = .fitBlue
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "name"
        lbl.font = UIFont(name: "ReemKufi", size: 25)
        lbl.textColor = .gray
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let userBioLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "user bio"
        lbl.font = UIFont(name: "ReemKufi", size: 15)
        lbl.textColor = .fitMystic
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let followersLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = " followers "
        lbl.font = UIFont(name: "ReemKufi", size: 25)
        lbl.textColor = .fitMystic
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let profilePhotoTest: UIImageView = {
        let img = UIImageView()
        img.layer.borderColor = UIColor.fitOrange.cgColor
        img.layer.borderWidth = 2
        img.layer.masksToBounds = false
        img.clipsToBounds = true
        img.sizeThatFits(CGSize.init(width: 80, height: 80))
        img.layer.cornerRadius = 65
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        posts = DatabaseRequest.shared.getProfilePosts(vc: self)
        updateProfile()
        view.addSubview(collectionView)
        let tabbarHeight = self.tabBarController?.tabBar.frame.size.height
        collectionView.frame = view.bounds.inset(by: UIEdgeInsets(top: 300, left: 10, bottom: tabbarHeight!, right: 10))
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        buttonConstraints()
        profileLabelConstraints()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.reloadInputViews()
        posts = DatabaseRequest.shared.getProfilePosts(vc: self)
        updateProfile()
    }
    
   
    
    private func profileLabelConstraints() {
        view.addSubview(usernameLabel)
        view.addSubview(userBioLabel)
        view.addSubview(followersLabel)
        view.addSubview(profilePhotoTest)
        view.addSubview(nameLabel)
        
        buttonConstraints()
        
        NSLayoutConstraint.activate([
            
            profilePhotoTest.topAnchor.constraint(equalTo: settingsButton.bottomAnchor, constant: -10),
            profilePhotoTest.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            profilePhotoTest.widthAnchor.constraint(equalToConstant: 130),
            profilePhotoTest.heightAnchor.constraint(equalTo: profilePhotoTest.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: settingsButton.bottomAnchor, constant: -5),
            usernameLabel.leadingAnchor.constraint(equalTo: profilePhotoTest.trailingAnchor, constant: 15),
            
            nameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: -5),
            nameLabel.leadingAnchor.constraint(equalTo: profilePhotoTest.trailingAnchor, constant: 15),
            
            userBioLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            userBioLabel.leadingAnchor.constraint(equalTo: profilePhotoTest.trailingAnchor, constant: 15),
            
            followersLabel.topAnchor.constraint(equalTo: profilePhotoTest.bottomAnchor, constant: 10),
            followersLabel.centerXAnchor.constraint(equalTo: profilePhotoTest.centerXAnchor),
            
            ])
        
    }
    
    private func buttonConstraints() {
        
        view.addSubview(settingsButton)
        view.addSubview(createPostButton)
        
        NSLayoutConstraint.activate([
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            settingsButton.heightAnchor.constraint(equalToConstant: 40),
            settingsButton.widthAnchor.constraint(equalToConstant: 45),

            createPostButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            createPostButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            createPostButton.heightAnchor.constraint(equalToConstant: 40),
            createPostButton.widthAnchor.constraint(equalToConstant: 45)
            ])
        settingsButton.addTarget(self, action: #selector(didTapSettings(_:)), for: .touchUpInside)
        createPostButton.addTarget(self, action: #selector(didTapCreatePost(_:)), for: .touchUpInside)
    }
    
    @objc func didTapSettings(_ sender: UIButton) {
        let vc = settingsVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @objc func didTapCreatePost(_ sneder: UIButton) {
        let vc = CreatePostVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func updateProfile() {
//        posts = DatabaseRequest.shared.getProfilePosts(vc: self)
        
        guard let userInfo = AuthManager.shared.currentUser else { return }
        usernameLabel.text = userInfo.username
        if userInfo.userBio != "" {
            userBioLabel.text = userInfo.userBio
        }
        followersLabel.text = "followers: \(userInfo.friends.count)"
        
        let uPhotoURL = userInfo.photoURL
        
        if uPhotoURL != "" {
            StorageManager.shared.getPicture(photoURL: uPhotoURL) { result in
                switch result {
                case .success(let photoImage):
                    self.profilePhotoTest.image = photoImage
                    
                case .failure(let error):
                    print("Storage Manager error \(error)")
                }
            }
        } else {
            self.profilePhotoTest.image = tempImage
        }
        
        nameLabel.text = "\(userInfo.fullname)"
        
        collectionView.reloadData()
    }
    
    
}

extension ProfileVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
    UICollectionViewCell {
        let thisPost = posts?[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfilePostCell.reuseIdentifier, for: indexPath) as! ProfilePostCell
        cell.symbol = thisPost
        return cell
    }
}

extension ProfileVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width * 0.9, height: 150)
    }
}
