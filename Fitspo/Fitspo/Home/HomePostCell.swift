//
//  HomePostCell.swift
//  Fitspo
//
//  Created by Noah Yin on 4/26/22.
//

import UIKit
import Firebase

class HomePostCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = String(describing: HomePostCell.self)
    
    let tempImage: UIImage = UIImage(named: "no-profile-image")!
    
    var canImage: UIImage?
    
    let storage = Storage.storage()
    
    var PPURL: String?
        
    func getProfilePhotoURL(new: User) {
        PPURL = new.photoURL
        
        guard let uPhotoURL = PPURL else { return }
        print("Profile Pic URL \(uPhotoURL)")
        
        if uPhotoURL != "" {
            StorageManager.shared.getPicture(photoURL: uPhotoURL) { result in
                switch result {
                case .success(let photoImage):
                    self.postProfilePicView.image = photoImage
                    
                case .failure(let error):
                    print("Storage Manager error \(error)")
                }
            }
        } else {
            self.postProfilePicView.image = UIImage(named: "no-profile-image")!
        }
    }
        
    var symbol: Post? {
        didSet {
        
            guard let postCreatorURL = symbol?.creator else { return }
            
            let creatorInfo = DatabaseRequest.shared.getUserData(cell: self, creatorURL: postCreatorURL)
            print("this is creatorInfo URL: \(creatorInfo.photoURL)")
            captionView.text = " \(symbol?.caption ?? "") "
            if symbol?.photos != "" {
                StorageManager.shared.getPicture(photoURL: symbol!.photos) { result in
                    switch result {
                    case .success(let photoImage):
                        self.imageView.image = photoImage

                    case .failure(let error):
                        print("Storage Manager error \(error)")
                    }
                }
            }
            
            let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .ultraLight, scale: .medium)
            self.likeView.image = UIImage(systemName: "heart", withConfiguration: configuration)?.withTintColor(.black, renderingMode: .alwaysOriginal)
            self.commentView.image = UIImage(systemName: "message", withConfiguration: configuration)?.withTintColor(.black, renderingMode: .alwaysOriginal)
            
            retrieveProfilePic()
            
            
            
            
            usernameView.text = " \(symbol?.username ?? "") "
            if (symbol?.location ?? "" == "") {
            } else {
                locationView.text = symbol?.location ?? ""
            }
            
            if (locationView.text == "Berkeley") {
                locationBackground.image = UIImage(named: "berkeleybackgroundfitspo")
            } else if (locationView.text == "San Francisco") {
                locationBackground.image = UIImage(named: "sfborder")
            } else {
                locationBackground.image = UIImage(named: "whitebackground")
            }
        }
    }
    
    let usernameView: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "ReemKufi", size: 25)
        return lbl
    }()
    
    let locationView: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "ReemKufi", size: 35)
        return lbl
    }()
    
    let captionView: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "ReemKufi-Thin", size: 15)
        return lbl
    }()
    
    let timeView: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.borderColor = UIColor.black.cgColor
        img.layer.borderWidth = 2
        img.layer.shadowOffset = CGSize(width: 0, height: 5)
        img.layer.shadowColor = UIColor.black.cgColor
        img.layer.shadowRadius = 3
        img.layer.shadowOpacity = 0.80
        return img
    }()
    
    
    let postProfilePicView: UIImageView = {
        let img = UIImageView()
        img.layer.borderColor = UIColor.fitOrange.cgColor
        img.layer.borderWidth = 2
        img.layer.masksToBounds = false
        img.clipsToBounds = true
        img.sizeThatFits(CGSize.init(width: 40, height: 40))
        img.layer.cornerRadius = 35
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let wardrobeView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.borderColor = UIColor.fitOrange.cgColor
        img.layer.borderWidth = 1
        img.layer.masksToBounds = false
        img.clipsToBounds = true
        img.sizeThatFits(CGSize.init(width: 35, height: 35))
        img.layer.cornerRadius = 20
        return img
    }()
    
    let wardrobeView2: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.borderColor = UIColor.fitOrange.cgColor
        img.layer.borderWidth = 1
        img.layer.masksToBounds = false
        img.clipsToBounds = true
        img.sizeThatFits(CGSize.init(width: 35, height: 35))
        img.layer.cornerRadius = 20
        return img
    }()
    
    let wardrobeView3: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.borderColor = UIColor.fitOrange.cgColor
        img.layer.borderWidth = 1
        img.layer.masksToBounds = false
        img.clipsToBounds = true
        img.sizeThatFits(CGSize.init(width: 35, height: 35))
        img.layer.cornerRadius = 20
        return img
    }()
    
    let wardrobeView4: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.borderColor = UIColor.fitOrange.cgColor
        img.layer.borderWidth = 1
        img.layer.masksToBounds = false
        img.clipsToBounds = true
        img.sizeThatFits(CGSize.init(width: 35, height: 35))
        img.layer.cornerRadius = 20
        return img
    }()
    
    let likeView: UIImageView = {
        let img = UIImageView()
        img.layer.masksToBounds = false
        img.sizeThatFits(CGSize.init(width: 20, height: 20))
        img.layer.cornerRadius = 20
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let commentView: UIImageView = {
        let img = UIImageView()
        img.layer.masksToBounds = false
        img.sizeThatFits(CGSize.init(width: 20, height: 20))
        img.layer.cornerRadius = 20
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let locationBackground: UIImageView = {
        let img = UIImageView()
        img.layer.masksToBounds = false
        img.sizeThatFits(CGSize.init(width: 20, height: 20))
        img.layer.cornerRadius = 20
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
//        contentView.layer.borderWidth = 1
//        contentView.layer.borderColor = UIColor.fitLavendar.cgColor
        
        setConstraints()
    }
    
    func setConstraints() {
        contentView.addSubview(locationBackground)
        contentView.addSubview(captionView)
        contentView.addSubview(imageView)
        contentView.addSubview(locationView)
        contentView.addSubview(usernameView)
        contentView.addSubview(postProfilePicView)
        contentView.addSubview(wardrobeView)
        contentView.addSubview(wardrobeView2)
        contentView.addSubview(wardrobeView3)
        contentView.addSubview(wardrobeView4)
        contentView.addSubview(likeView)
        contentView.addSubview(commentView)
        contentView.addSubview(timeView)
        
        let g = UILayoutGuide()
        self.contentView.addLayoutGuide(g)
        g.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        g.bottomAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        g.leadingAnchor.constraint(equalTo:contentView.leadingAnchor).isActive = true
        g.trailingAnchor.constraint(equalTo:contentView.trailingAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            
            locationBackground.topAnchor.constraint(equalTo: g.topAnchor),
            locationBackground.centerYAnchor.constraint(equalTo: g.centerYAnchor),
            locationBackground.centerXAnchor.constraint(equalTo: g.centerXAnchor),
            locationBackground.bottomAnchor.constraint(equalTo: g.bottomAnchor),
            locationBackground.trailingAnchor.constraint(equalTo: g.trailingAnchor),
            
            locationView.heightAnchor.constraint(equalTo: postProfilePicView.heightAnchor),
            locationView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            locationView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20),
            locationView.centerYAnchor.constraint(equalTo: g.centerYAnchor),
            
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -110),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            wardrobeView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            wardrobeView.widthAnchor.constraint(equalTo: wardrobeView.heightAnchor),
            wardrobeView.centerXAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            wardrobeView.centerYAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 55),
            
            wardrobeView2.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            wardrobeView2.widthAnchor.constraint(equalTo: wardrobeView.heightAnchor),
            wardrobeView2.leadingAnchor.constraint(equalTo: wardrobeView.trailingAnchor, constant: 19),
            wardrobeView2.centerYAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 55),
            
            wardrobeView3.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            wardrobeView3.widthAnchor.constraint(equalTo: wardrobeView.heightAnchor),
            wardrobeView3.leadingAnchor.constraint(equalTo: wardrobeView2.trailingAnchor, constant: 20),
            wardrobeView3.centerYAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 55),
            
            wardrobeView4.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            wardrobeView4.widthAnchor.constraint(equalTo: wardrobeView.heightAnchor),
            wardrobeView4.leadingAnchor.constraint(equalTo: wardrobeView3.trailingAnchor, constant: 19),
            wardrobeView4.centerYAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 55),
            
            postProfilePicView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.18),
            postProfilePicView.widthAnchor.constraint(equalTo: postProfilePicView.heightAnchor),
            postProfilePicView.centerXAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 55),
            postProfilePicView.centerYAnchor.constraint(equalTo: wardrobeView.bottomAnchor, constant: 65),
            
            timeView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.18),
            timeView.widthAnchor.constraint(equalTo: postProfilePicView.heightAnchor),
            timeView.centerXAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 55),
            timeView.centerYAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
            
            usernameView.leadingAnchor.constraint(equalTo: postProfilePicView.trailingAnchor, constant: 20),
            usernameView.centerYAnchor.constraint(equalTo: postProfilePicView.topAnchor, constant: 15),
            
            captionView.leadingAnchor.constraint(equalTo: postProfilePicView.trailingAnchor, constant: 20),
            captionView.topAnchor.constraint(equalTo: usernameView.bottomAnchor, constant: 10),
            
            likeView.heightAnchor.constraint(equalTo: wardrobeView.heightAnchor, multiplier: 0.55),
            likeView.widthAnchor.constraint(equalTo: likeView.heightAnchor),
            likeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            likeView.topAnchor.constraint(equalTo: wardrobeView.bottomAnchor, constant: 20),
            
            commentView.heightAnchor.constraint(equalTo: wardrobeView.heightAnchor, multiplier: 0.55),
            commentView.widthAnchor.constraint(equalTo: likeView.heightAnchor),
            commentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            commentView.topAnchor.constraint(equalTo: likeView.bottomAnchor, constant: 10),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // set imageView and photo to nil
    }
    
    func retrieveProfilePic() {
        
        guard let userInfo = AuthManager.shared.currentUser else { return }
        
        let uPhotoURL = userInfo.photoURL
        
        if uPhotoURL != "" {
            StorageManager.shared.getPicture(photoURL: uPhotoURL) { result in
                switch result {
                case .success(let photoImage):
                    self.postProfilePicView.image = photoImage
                    
                case .failure(let error):
                    print("Storage Manager error \(error)")
                }
            }
        } else {
            self.postProfilePicView.image = UIImage(named: "no-profile-image")!
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension UIImageView {
    func applyshadowWithCorner(containerView : UIView, cornerRadious : CGFloat){
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowRadius = 10
        containerView.layer.cornerRadius = cornerRadious
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadious).cgPath
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadious
    }
}
