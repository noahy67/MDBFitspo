//
//  SignUpVC.swift
//  Fitspo
//
//  Created by Noah Yin on 4/17/22.
//

import UIKit
import NotificationBannerSwift

class SignUpVC: UIViewController {
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 25

        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "To Create Your Account,"
        lbl.textColor = .fitOrange
        lbl.font = .systemFont(ofSize: 30, weight: .semibold)
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let titleSecLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Please fill in the blanks"
        lbl.textColor = .secondaryText
        lbl.font = .systemFont(ofSize: 17, weight: .medium)
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let emailTextField: AuthTextField = {
        let tf = AuthTextField(title: "Email:")
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let passwordTextField: AuthTextField = {
        let tf = AuthTextField(title: "Password:")
        tf.textField.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let passwordReentryTextField: AuthTextField = {
        let tf = AuthTextField(title: "Confirm Password:")
        tf.textField.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let nameTextField: AuthTextField = {
        let tf = AuthTextField(title: "Full Name:")
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let usernameTextField: AuthTextField = {
        let tf = AuthTextField(title: "Username:")
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let signupButton: LoadingButton = {
        let btn = LoadingButton()
        btn.layer.backgroundColor = UIColor.fitOrange.cgColor
        btn.setTitle("Sign Up", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        btn.isUserInteractionEnabled = true
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let haveAccountActionLabel: HorizontalActionLabel = {
        let actionLabel = HorizontalActionLabel(
            label: "Already have an account?",
            buttonTitle: "Sign In")
        
        actionLabel.translatesAutoresizingMaskIntoConstraints = false
        return actionLabel
    }()
    
    private let contentEdgeInset = UIEdgeInsets(top: 30, left: 40, bottom: 30, right: 40)
    
    private let signupButtonHeight: CGFloat = 44.0

    private var bannerQueue = NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        view.backgroundColor = .background
        
        view.addSubview(titleLabel)
        view.addSubview(titleSecLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                            constant: contentEdgeInset.top),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                constant: contentEdgeInset.left),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                 constant: contentEdgeInset.right),
            titleSecLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                               constant: 3),
            titleSecLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            titleSecLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
        
        view.addSubview(stack)
        stack.addArrangedSubview(nameTextField)
        stack.addArrangedSubview(emailTextField)
        stack.addArrangedSubview(usernameTextField)
        stack.addArrangedSubview(passwordTextField)
        stack.addArrangedSubview(passwordReentryTextField)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: contentEdgeInset.left),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                            constant: -contentEdgeInset.right),
            stack.topAnchor.constraint(equalTo: titleSecLabel.bottomAnchor,
                                       constant: 40)
        ])
        
        view.addSubview(signupButton)
        view.addSubview(haveAccountActionLabel)
        NSLayoutConstraint.activate([
            signupButton.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            signupButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 30),
            signupButton.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            signupButton.heightAnchor.constraint(equalToConstant: signupButtonHeight)
        ])
        
        NSLayoutConstraint.activate([
            haveAccountActionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            haveAccountActionLabel.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 50)
            
        ])
        
        signupButton.layer.cornerRadius = signupButtonHeight / 2
        
        signupButton.addTarget(self, action: #selector(didTapSignUp(_:)), for: .touchUpInside)

        haveAccountActionLabel.addTarget(self, action: #selector(didTapHaveAccount(_:)), for: .touchUpInside)
    }

    @objc private func didTapHaveAccount(_ sender: UIButton) {
        guard let window = self.view.window else { return }
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        window.rootViewController = vc
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.3
        UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: nil)
    }

    @objc private func didTapSignUp(_ sender: UIButton) {
        guard let email = emailTextField.text, email != "" else {
            showErrorBanner(withTitle: "Missing email", subtitle: "Please enter you email address")
            return
        }

        guard let password = passwordTextField.text, password != "" else {
            showErrorBanner(withTitle: "Missing password", subtitle: "Please enter your password")
            return
        }
        
        guard let passwordC = passwordReentryTextField.text, passwordC != "" else {
            showErrorBanner(withTitle: "Missing password confirmation", subtitle: "Please confirm your password")
            return
        }
        
        guard let name = nameTextField.text, name != "" else {
            showErrorBanner(withTitle: "Missing name", subtitle: "Please enter your name")
            return
        }
        
        guard let user = usernameTextField.text, user != "" else {
            showErrorBanner(withTitle: "Missing username", subtitle: "Please enter your username")
            return
        }
        
        if password != passwordC {
            showErrorBanner(withTitle: "Passwords do not match", subtitle: "Please confirm the same password")
            return
        }
        
        signupButton.showLoading()
        AuthManager.shared.signUp(withEmail: email, password: password, name: name, username: user) { [weak self] result in
            guard let self = self else { return }
            
            defer {
                self.signupButton.hideLoading()
            }
            switch result {
            case .success:
                guard let window = self.view.window else { return }
                let vc = TabBarVC()
                window.rootViewController = vc
                let options: UIView.AnimationOptions = .transitionCrossDissolve
                let duration: TimeInterval = 0.3
                UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: nil)
                
            case .failure(let error):
                switch error {
                case .weakPassword:
                    self.showErrorBanner(withTitle: "Weak Password", subtitle: "Enter a stronger password")
                case .emailAlreadyInUse:
                    self.showErrorBanner(withTitle: "Email already in Use", subtitle: "Sign in or use a different email")
                default:
                    self.showErrorBanner(withTitle: "Internal error", subtitle: "")
                }
            }
        }
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


