//
//  ProfilePostCell.swift
//  Fitspo
//
//  Created by Noah Yin on 4/22/22.
//

import UIKit
import Firebase

class ProfilePostCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = String(describing: ProfilePostCell.self)
    
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
//            let imageRef: StorageReference = storage.reference(forURL: symbol!.photos)
//
//            imageRef.getData(maxSize: 1000 * 1000) { data, error in
//
//                if let error = error {
//                    print("Error: \(error)")
//                } else {
//                    print("get photo success")
//                    self.imageView.image = UIImage(data: data!)
//                }
//
//            }
            
        }
    }
    
    let captionView: UILabel = {
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
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            captionView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            captionView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
