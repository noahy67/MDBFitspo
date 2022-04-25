//
//  App.swift
//  Fitspo
//
//  Created by Jeffrey Yum on 4/24/22.
//

import Foundation

struct App: Decodable, Hashable {
    let id: Int
    let tagline: String
    let name: String
    let subheading: String
    let image: String
    let iap: Bool
}
