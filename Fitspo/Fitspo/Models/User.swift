//
//  User.swift
//  Fitspo
//
//  Created by Noah Yin on 4/17/22.
//

import Foundation
import FirebaseFirestoreSwift

typealias UserID = String

struct User: Codable {
    @DocumentID var uid: UserID?
    
    var username: String
    
    var email: String
    
    var fullname: String
    
    var userBio: String
    
    var photoURL: String
    
    var allPosts: [PostID]

    var friends: [UserID]

    var savedPosts: [PostID]

    var userWardrobe: [WardrobeItemID]
}
