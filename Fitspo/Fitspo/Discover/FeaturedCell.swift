//
//  FeaturedCellCollectionViewCell.swift
//  Fitspo
//
//  Created by Jeffrey Yum on 4/22/22.
//

import UIKit

class FeaturedCell: UICollectionViewCell, SelfConfiguringCell {
    static let reuseIdentifier: String = "FeaturedCell"

    let tagline = UILabel()
    let name = UILabel()
    let subtitle = UILabel()
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        let separator = UIView(frame: .zero)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .quaternaryLabel

//        tagline.font = UIFont(name: "ReemKufi", size: 20)
        
        tagline.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 15, weight: .bold))
        tagline.textColor = .systemBlue

        name.font = UIFont(name: "ReemKufi", size: 25)
        name.textColor = .label

        subtitle.font = UIFont(name: "ReemKufi", size: 15)
        subtitle.textColor = .secondaryLabel

        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit

        let stackView = UIStackView(arrangedSubviews: [separator, tagline, name, subtitle, imageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),

            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        stackView.setCustomSpacing(10, after: separator)
        stackView.setCustomSpacing(10, after: subtitle)
    }

    func configure(with app: App) {
        tagline.text = app.tagline.uppercased()
        name.text = app.name
        subtitle.text = app.subheading
        imageView.image = UIImage(named: app.image)
    }

    required init?(coder: NSCoder) {
        fatalError("Not happening")
    }
}
