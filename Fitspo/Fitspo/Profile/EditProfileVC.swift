//
//  EditProfileVC.swift
//  Fitspo
//
//  Created by Noah Yin on 4/18/22.
//

import UIKit
import NotificationBannerSwift
import Firebase
import FirebaseStorage
import SwiftUI

class EditProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let storage = Storage.storage()
    
    var tempImage: UIImage? = nil
    
    var didTakePicture: Bool = false
    
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
    
    private let doneButton: LoadingButton = {
        let btn = LoadingButton()
        btn.layer.backgroundColor = UIColor.fitOrange.cgColor
        btn.setTitle(" Done ", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 10
        btn.isUserInteractionEnabled = true
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let photoButton: UIButton = {
        let btn = UIButton()
        btn.setTitle(" Take Profile Pic ", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .fitOrange
        btn.layer.cornerRadius = 10
        btn.layer.shadowRadius = 10
        btn.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 25

        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let usernameTextField: AuthTextField = {
        let tf = AuthTextField(title: "Username:")
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let userBioTextField: AuthTextField = {
        let tf = AuthTextField(title: "Bio:")
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let profilePhotoTest: UIImageView = {
        let img = UIImageView()
        img.layer.borderColor = UIColor.fitOrange.cgColor
        img.layer.borderWidth = 5
        img.layer.masksToBounds = false
        img.clipsToBounds = true
        img.sizeThatFits(CGSize.init(width: 100, height: 100))
        img.layer.cornerRadius = 100 / 2
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let contentEdgeInset = UIEdgeInsets(top: 120, left: 40, bottom: 30, right: 40)
    private var bannerQueue = NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        buttonConstraints()
        stackConstraints()
        view.addSubview(profilePhotoTest)
        NSLayoutConstraint.activate([
            profilePhotoTest.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 50),
            profilePhotoTest.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -50),
            profilePhotoTest.trailingAnchor.constraint(equalTo: profilePhotoTest.leadingAnchor, constant: 100),
            profilePhotoTest.bottomAnchor.constraint(equalTo: profilePhotoTest.topAnchor, constant: 100)
        ])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presentingViewController?.viewWillAppear(true)
    }
    
    private func buttonConstraints() {
        view.addSubview(backButton)
        view.addSubview(doneButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
            ])
        
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
            ])
        
        backButton.addTarget(self, action: #selector(didTapBackButton(_:)), for: .touchUpInside)
        
        doneButton.addTarget(self, action: #selector(didTapDone(_:)), for: .touchUpInside)
    }
    
    private func stackConstraints() {
        view.addSubview(stack)
        stack.addArrangedSubview(usernameTextField)
        stack.addArrangedSubview(userBioTextField)
        stack.addArrangedSubview(photoButton)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: contentEdgeInset.left),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                            constant: -contentEdgeInset.right),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                       constant: 180)
        ])
        
        photoButton.addTarget(self, action: #selector(didTapPhotoButton(_:)), for: .touchUpInside)
    }
    
    @objc func didTapBackButton(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapDone(_ sender: UIButton) {
        
        guard let newUsername = usernameTextField.text else { return }
        guard let newBio = userBioTextField.text else { return }
        
        if newUsername != "" {
            AuthManager.shared.currentUser?.username = newUsername
        }
        if newBio != "" {
            AuthManager.shared.currentUser?.userBio = newBio
        }
        
        if didTakePicture == true && tempImage != nil {
            
            guard let emailaddress = AuthManager.shared.currentUser?.email else { return }
            
            guard let tempy = tempImage else { return }
            
            StorageManager.shared.uploadProfilePicture(with: tempy, fileName: emailaddress) { result in
                switch result {
                case .success(let downloadURL):
                    AuthManager.shared.currentUser?.photoURL = downloadURL
                    guard let newUserInfo = AuthManager.shared.currentUser else { return }
                    DatabaseRequest.shared.setUser(newUserInfo) {
                        self.dismiss(animated: true, completion: nil)
                    }
                
                case .failure(let error):
                    print("Storage Manager Error \(error)")
                }
            }
            
        } else {
            guard let newUserInfo = AuthManager.shared.currentUser else { return }
            DatabaseRequest.shared.setUser(newUserInfo) {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        
//        guard let window = self.view.window else { return }
//        let vc = TabBarVC()
//        window.rootViewController = vc
//        let options: UIView.AnimationOptions = .transitionCrossDissolve
//        let duration: TimeInterval = 0.3
//        UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: nil)
        
    }
    
    @objc private func didTapPhotoButton(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        profilePhotoTest.contentMode = .scaleAspectFit
        profilePhotoTest.image = image
        tempImage = image
        didTakePicture = true
        
        
        picker.dismiss(animated: true) { () }
    }
    
    private func showErrorBanner(withTitle title: String, subtitle: String? = nil) {
        showBanner(withStyle: .warning, title: title, subtitle: subtitle)
    }
    
    private func showBanner(withStyle style: BannerStyle, title: String, subtitle: String?) {
        guard bannerQueue.numberOfBanners == 0 else { return }
        let banner = FloatingNotificationBanner(title: title, subtitle: subtitle,
                                                titleFont: .systemFont(ofSize: 17, weight: .medium),
                                                subtitleFont: .systemFont(ofSize: 14, weight: .regular),
                                                style: style)
        
        banner.show(bannerPosition: .top,
                    queue: bannerQueue,
                    edgeInsets: UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15),
                    cornerRadius: 10,
                    shadowColor: .primaryText,
                    shadowOpacity: 0.3,
                    shadowBlurRadius: 10)
        
    }
}
