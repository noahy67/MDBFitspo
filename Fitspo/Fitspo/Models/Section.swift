//
//  Section.swift
//  Fitspo
//
//  Created by Jeffrey Yum on 4/22/22.
//

import Foundation

struct Section: Decodable, Hashable {
    let id: Int
    let type: String
    let title: String
    let subtitle: String
    let items: [App]
}
