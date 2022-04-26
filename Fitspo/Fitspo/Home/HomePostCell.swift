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
            captionView.text = symbol?.caption
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
            timeView.text = "\(String(describing: symbol?.postTimeStamp))"
            
        }
    }
    
    let captionView: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
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
        
        NSLayoutConstraint.activate([
            
            
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            
            captionView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            captionView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
