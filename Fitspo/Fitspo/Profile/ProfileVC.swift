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
    
    let storage = Storage.storage()
    let tempImage: UIImage = UIImage(named: "no-profile-image")!
    
    private let signOutButton: UIButton = {
        let btn = UIButton()
        btn.setTitle(" Sign Out ", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .fitOrange
        btn.layer.cornerRadius = 10
        btn.layer.shadowRadius = 10
        btn.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let editProfileButton: UIButton = {
        let btn = UIButton()
        btn.setTitle(" Edit Profile ", for: .normal)
        btn.setTitleColor(.fitOrange, for: .normal)
        btn.backgroundColor = .clear
        btn.layer.cornerRadius = 10
        btn.layer.shadowRadius = 10
        btn.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let createPostButton: UIButton = {
        let btn = UIButton()
        btn.setTitle(" Create A Post ", for: .normal)
        btn.setTitleColor(.fitOrange, for: .normal)
        btn.backgroundColor = .clear
        btn.layer.cornerRadius = 10
        btn.layer.shadowRadius = 10
        btn.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let usernameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "username"
        lbl.font = .systemFont(ofSize: 30, weight: .bold)
        lbl.textColor = .fitBlue
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let userBioLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "user bio"
        lbl.font = .systemFont(ofSize: 20, weight: .semibold)
        lbl.textColor = .fitLavendar
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let followersLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "followers"
        lbl.font = .systemFont(ofSize: 20, weight: .semibold)
        lbl.textColor = .fitLavendar
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let profilePhotoTest: UIImageView = {
        let img = UIImageView()
        img.layer.borderColor = UIColor.fitOrange.cgColor
        img.layer.borderWidth = 5
        img.layer.masksToBounds = false
        img.clipsToBounds = true
        img.sizeThatFits(CGSize.init(width: 160, height: 160))
        img.layer.cornerRadius = 160 / 2
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        updateProfile()
        buttonConstraints()
        profileLabelConstraints()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateProfile()
    }
    
    
    private func profileLabelConstraints() {
        view.addSubview(usernameLabel)
        view.addSubview(userBioLabel)
        view.addSubview(followersLabel)
        view.addSubview(profilePhotoTest)
        
        NSLayoutConstraint.activate([
            profilePhotoTest.topAnchor.constraint(equalTo: editProfileButton.bottomAnchor, constant: 20),
            profilePhotoTest.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            profilePhotoTest.trailingAnchor.constraint(equalTo: profilePhotoTest.leadingAnchor, constant: 160),
            profilePhotoTest.bottomAnchor.constraint(equalTo: profilePhotoTest.topAnchor, constant: 160)
            ])
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: editProfileButton.bottomAnchor, constant: 30),
            usernameLabel.leadingAnchor.constraint(equalTo: profilePhotoTest.trailingAnchor, constant: 10)
            ])
        
        NSLayoutConstraint.activate([
            userBioLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 20),
            userBioLabel.leadingAnchor.constraint(equalTo: profilePhotoTest.trailingAnchor, constant: 10)
            ])
        
        NSLayoutConstraint.activate([
            followersLabel.topAnchor.constraint(equalTo: userBioLabel.bottomAnchor, constant: 20),
            followersLabel.leadingAnchor.constraint(equalTo: profilePhotoTest.trailingAnchor, constant: 10)
            ])
        
    }
    
    private func buttonConstraints() {
        view.addSubview(signOutButton)
        view.addSubview(editProfileButton)
        view.addSubview(createPostButton)
        NSLayoutConstraint.activate([
            signOutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            signOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
            ])
        signOutButton.addTarget(self, action: #selector(didTapSignOut(_:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            editProfileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            editProfileButton.trailingAnchor.constraint(equalTo: signOutButton.leadingAnchor, constant: -20)
            ])
        
        editProfileButton.addTarget(self, action: #selector(didTapEditProfile(_:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            createPostButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            createPostButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
            ])
        
        createPostButton.addTarget(self, action: #selector(didTapCreatePost(_:)), for: .touchUpInside)
    }
    
    @objc func didTapSignOut(_ sender: UIButton) {
        AuthManager.shared.signOut {
            guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return }
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            window.rootViewController = vc
            let options: UIView.AnimationOptions = .transitionCrossDissolve
            let duration: TimeInterval = 0.3
            UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: nil)
        }
    }
    
    @objc func didTapEditProfile(_ sender: UIButton) {
        let vc = EditProfileVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @objc func didTapCreatePost(_ sneder: UIButton) {
        let vc = CreatePostVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func updateProfile() {
        guard let userInfo = AuthManager.shared.currentUser else { return }
        usernameLabel.text = userInfo.username
        if userInfo.userBio != "" {
            userBioLabel.text = userInfo.userBio
        }
        followersLabel.text = "followers: \(userInfo.friends.count)"
        
        let uPhotoURL = userInfo.photoURL
        
        StorageManager.shared.getPicture(photoURL: uPhotoURL) { result in
            switch result {
            case .success(let photoImage):
                self.profilePhotoTest.image = photoImage
                
            case .failure(let error):
                print("Storage Manager error \(error)")
            }
        }
        
        
    }
    
}
