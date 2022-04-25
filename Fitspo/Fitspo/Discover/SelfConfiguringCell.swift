//
//  SelfConfiguringCell.swift
//  Fitspo
//
//  Created by Jeffrey Yum on 4/22/22.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseIdentifier: String { get }
    func configure(with app: App)
}
