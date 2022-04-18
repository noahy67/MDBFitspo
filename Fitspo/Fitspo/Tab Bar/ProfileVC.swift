//
//  ProfileVC.swift
//  Fitspo
//
//  Created by Noah Yin on 4/17/22.
//

import UIKit

class ProfileVC: UIViewController {
    
    private let signOutButton: UIButton = {
        let btn = UIButton()
        btn.setTitle(" Sign Out ", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 10
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        buttonConstraints()
        // Do any additional setup after loading the view.
    }
    
    private func buttonConstraints() {
        view.addSubview(signOutButton)
        NSLayoutConstraint.activate([
            signOutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            signOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
            ])
        signOutButton.addTarget(self, action: #selector(didTapSignOut(_:)), for: .touchUpInside)
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
