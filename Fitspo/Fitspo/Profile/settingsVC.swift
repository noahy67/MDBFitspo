//
//  settingsButton.swift
//  Fitspo
//
//  Created by Jeffrey Yum on 4/27/22.
//

import Foundation
import UIKit

class settingsVC: UIViewController {
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        buttonConstraints()
    }
    
    
    private func buttonConstraints() {
        view.addSubview(signOutButton)
        view.addSubview(editProfileButton)
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            
            editProfileButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -40),
            editProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            signOutButton.topAnchor.constraint(equalTo: editProfileButton.bottomAnchor, constant: 10),
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])
        
        backButton.addTarget(self, action: #selector(didTapBackButton(_:)), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTapEditProfile(_:)), for: .touchUpInside)
        signOutButton.addTarget(self, action: #selector(didTapSignOut(_:)), for: .touchUpInside)
    }
    
    @objc func didTapBackButton(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapEditProfile(_ sender: UIButton) {
        let vc = EditProfileVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
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
}

