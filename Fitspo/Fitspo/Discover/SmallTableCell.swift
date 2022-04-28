//
//  SmallTableCell.swift
//  Fitspo
//
//  Created by Jeffrey Yum on 4/24/22.
//

import UIKit

class SmallTableCell: UICollectionViewCell, SelfConfiguringCell {
    static let reuseIdentifier: String = "SmallTableCell"

    let name = UILabel()
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        //change font here
        name.font = UIFont(name: "ReemKufi", size: 25)
        name.textColor = .label

        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true

        let stackView = UIStackView(arrangedSubviews: [imageView, name])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = 20
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func configure(with app: App) {
        name.text = app.name
        imageView.image = UIImage(named: app.image)
    }

    required init?(coder: NSCoder) {
        fatalError("No")
    }
}
