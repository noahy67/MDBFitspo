/
//  WardrobeCell.swift
//  Fitspo
//
//  Created by Noah Yin on 4/27/22.
//

import UIKit

class WardrobeCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = String(describing: WardrobeCell.self)
    
    
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
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .fitOrange
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
