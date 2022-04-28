//
//  WardrobeCell.swift
//  Fitspo
//
//  Created by Noah Yin on 4/27/22.
//

import UIKit
import Firebase

class WardrobeCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = String(describing: WardrobeCell.self)
    
    let storage = Storage.storage()
    
    var symbol: WardrobeItem? {
        didSet {
            captionView.text = "DOES IT WORK"
            
            if symbol?.photoURL != "" {
                StorageManager.shared.getPicture(photoURL: symbol!.photoURL) { result in
                    switch result {
                    case .success(let photoImage):
                        self.imageView.image = photoImage

                    case .failure(let error):
                        print("Storage Manager error \(error)")
                    }
                }
            }
            
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
        img.layer.borderColor = UIColor.fitOrange.cgColor
        img.layer.borderWidth = 3
        img.layer.masksToBounds = false
        img.clipsToBounds = true
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
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            captionView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            captionView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
