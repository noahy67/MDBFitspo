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
    
    var symbol: Post? {
        didSet {
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
            
            self.likeView.image = UIImage(systemName: "heart")
            self.commentView.image = UIImage(systemName: "message")
            
            retrieveProfilePic()
            
            
            usernameView.text = " \(symbol?.username ?? "") "
            usernameView2.text = " \(symbol?.username ?? "") "
            if (symbol?.location ?? "" == "") {
            } else {
                locationView.text = " from \(symbol?.location ?? "") "
            }
            timeView.text = "\(String(describing: symbol?.postTimeStamp))"
            
        }
    }
    
    let usernameView: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = lbl.font.withSize(20)
        lbl.font = lbl.font
        return lbl
    }()
    
    let usernameView2: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 20.0)
        return lbl
    }()
    
    let locationView: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = lbl.font.withSize(15)
        return lbl
    }()
    
    let captionView: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = lbl.font.withSize(20)
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
        return img
    }()
    
    let postProfilePicView: UIImageView = {
        let img = UIImageView()
        img.layer.borderColor = UIColor.fitOrange.cgColor
        img.layer.borderWidth = 2
        img.layer.masksToBounds = false
        img.clipsToBounds = true
        img.sizeThatFits(CGSize.init(width: 40, height: 40))
        img.layer.cornerRadius = 30
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let wardrobeView: UIImageView = {
        let img = UIImageView()
        img.layer.borderColor = UIColor.fitOrange.cgColor
        img.layer.borderWidth = 2
        img.layer.masksToBounds = false
        img.clipsToBounds = true
        img.sizeThatFits(CGSize.init(width: 35, height: 35))
        img.layer.cornerRadius = 20
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let wardrobeView2: UIImageView = {
        let img = UIImageView()
        img.layer.borderColor = UIColor.fitOrange.cgColor
        img.layer.borderWidth = 2
        img.layer.masksToBounds = false
        img.clipsToBounds = true
        img.sizeThatFits(CGSize.init(width: 35, height: 35))
        img.layer.cornerRadius = 20
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let wardrobeView3: UIImageView = {
        let img = UIImageView()
        img.layer.borderColor = UIColor.fitOrange.cgColor
        img.layer.borderWidth = 2
        img.layer.masksToBounds = false
        img.clipsToBounds = true
        img.sizeThatFits(CGSize.init(width: 35, height: 35))
        img.layer.cornerRadius = 20
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let wardrobeView4: UIImageView = {
        let img = UIImageView()
        img.layer.borderColor = UIColor.fitOrange.cgColor
        img.layer.borderWidth = 2
        img.layer.masksToBounds = false
        img.clipsToBounds = true
        img.sizeThatFits(CGSize.init(width: 35, height: 35))
        img.layer.cornerRadius = 20
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let wardrobeView5: UIImageView = {
        let img = UIImageView()
        img.layer.borderColor = UIColor.fitOrange.cgColor
        img.layer.borderWidth = 2
        img.layer.masksToBounds = false
        img.clipsToBounds = true
        img.sizeThatFits(CGSize.init(width: 35, height: 35))
        img.layer.cornerRadius = 20
        img.translatesAutoresizingMaskIntoConstraints = false
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
//        contentView.layer.borderWidth = 1
//        contentView.layer.borderColor = UIColor.fitLavendar.cgColor
        
        setConstraints()
    }
    
    func setConstraints() {
        contentView.addSubview(captionView)
        contentView.addSubview(imageView)
        contentView.addSubview(locationView)
        contentView.addSubview(usernameView)
        contentView.addSubview(postProfilePicView)
        contentView.addSubview(usernameView2)
        contentView.addSubview(wardrobeView)
        contentView.addSubview(wardrobeView2)
        contentView.addSubview(wardrobeView3)
        contentView.addSubview(wardrobeView4)
        contentView.addSubview(wardrobeView5)
        contentView.addSubview(likeView)
        contentView.addSubview(commentView)
        
        NSLayoutConstraint.activate([
            
            
            postProfilePicView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.15),
            postProfilePicView.widthAnchor.constraint(equalTo: postProfilePicView.heightAnchor),
            postProfilePicView.centerXAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 55),
            postProfilePicView.centerYAnchor.constraint(equalTo: imageView.topAnchor, constant: -33),
            
            usernameView.heightAnchor.constraint(equalTo: postProfilePicView.heightAnchor),
            usernameView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            usernameView.leadingAnchor.constraint(equalTo: postProfilePicView.trailingAnchor, constant: 10),
            usernameView.centerYAnchor.constraint(equalTo: imageView.topAnchor, constant: -45),
            
            locationView.heightAnchor.constraint(equalTo: postProfilePicView.heightAnchor),
            locationView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            locationView.leadingAnchor.constraint(equalTo: postProfilePicView.trailingAnchor, constant: 10),
            locationView.centerYAnchor.constraint(equalTo: imageView.topAnchor, constant: -15),
            
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -50),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            wardrobeView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.15),
            wardrobeView.widthAnchor.constraint(equalTo: wardrobeView.heightAnchor),
            wardrobeView.centerXAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            wardrobeView.centerYAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 35),
            
            wardrobeView2.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.15),
            wardrobeView2.widthAnchor.constraint(equalTo: wardrobeView.heightAnchor),
            wardrobeView2.leadingAnchor.constraint(equalTo: wardrobeView.trailingAnchor, constant: 19),
            wardrobeView2.centerYAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 35),
            
            wardrobeView3.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.15),
            wardrobeView3.widthAnchor.constraint(equalTo: wardrobeView.heightAnchor),
            wardrobeView3.leadingAnchor.constraint(equalTo: wardrobeView2.trailingAnchor, constant: 20),
            wardrobeView3.centerYAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 35),
            
            wardrobeView4.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.15),
            wardrobeView4.widthAnchor.constraint(equalTo: wardrobeView.heightAnchor),
            wardrobeView4.leadingAnchor.constraint(equalTo: wardrobeView3.trailingAnchor, constant: 19),
            wardrobeView4.centerYAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 35),
            
            wardrobeView5.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.15),
            wardrobeView5.widthAnchor.constraint(equalTo: wardrobeView.heightAnchor),
            wardrobeView5.leadingAnchor.constraint(equalTo: wardrobeView4.trailingAnchor, constant: 19),
            wardrobeView5.centerYAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 35),
            
            usernameView2.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 10),
            usernameView2.topAnchor.constraint(equalTo: wardrobeView.bottomAnchor, constant: 20),
            
            captionView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 10),
            captionView.topAnchor.constraint(equalTo: usernameView2.bottomAnchor, constant: 20),
            
            likeView.heightAnchor.constraint(equalTo: wardrobeView.heightAnchor, multiplier: 0.6),
            likeView.widthAnchor.constraint(equalTo: likeView.heightAnchor),
            likeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            likeView.topAnchor.constraint(equalTo: wardrobeView.bottomAnchor, constant: 10),
            
            commentView.heightAnchor.constraint(equalTo: wardrobeView.heightAnchor, multiplier: 0.6),
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
