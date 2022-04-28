//
//  MediumTableCell.swift
//  Fitspo
//
//  Created by Jeffrey Yum on 4/24/22.
//

import UIKit

class MediumTableCell: UICollectionViewCell, SelfConfiguringCell {
    
    static let reuseIdentifier: String = "MediumTableCell"

    let name = UILabel()
    let subtitle = UILabel()
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        //change font here
        name.textColor = .label
        name.font = UIFont(name: "ReemKufi", size: 20)
        

        //change font here
        
        subtitle.textColor = .secondaryLabel
        subtitle.font = UIFont(name: "ReemKufi", size: 15)
        

        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true

        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        let innerStackView = UIStackView(arrangedSubviews: [name, subtitle])
        innerStackView.axis = .vertical
        
        

        let outerStackView = UIStackView(arrangedSubviews: [innerStackView])
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        outerStackView.alignment = .center
        outerStackView.spacing = 10
        contentView.addSubview(outerStackView)

        NSLayoutConstraint.activate([
            outerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            outerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            outerStackView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }

    func configure(with app: App) {
        name.text = app.name
        subtitle.text = app.subheading
        imageView.image = UIImage(named: app.image)
    }

    required init?(coder: NSCoder) {
        fatalError("noooooooo")
    }
}
