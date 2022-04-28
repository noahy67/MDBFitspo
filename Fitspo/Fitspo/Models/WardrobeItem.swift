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
    @DocumentID var id: WardrobeItemID? = UUID().uuidString
    
    var creator: UserID
    
    var tag: String
    
    var color: String
    
    var brand: String
    
    var type: String
    
    var itemURL: String
    
    var photoURL: String
    
}
