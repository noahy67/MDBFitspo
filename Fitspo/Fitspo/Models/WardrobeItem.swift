//
//  WardrobeItem.swift
//  Fitspo
//
//  Created by Noah Yin on 4/17/22.
//

import Foundation
import FirebaseFirestoreSwift

typealias WardrobeItemID = String

struct WardrobeItem: Codable {
    @DocumentID var uid: WardrobeItemID? = UUID().uuidString
    
    var color: String
    
    var brand: String
    
    var type: String
    
    var itemURL: String
    
    var photoURL: String
    
}
