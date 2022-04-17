//
//  Post.swift
//  Fitspo
//
//  Created by Noah Yin on 4/17/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

typealias PostID = String

struct Post: Codable {
    @DocumentID var uid: PostID? = UUID().uuidString
    
    var username: String
    
    var caption: String
    
    var comments: [String:String]
    
    var creator: UserID
    
    var likedUsers: [UserID]
    
    var location: String
    
    var photos: [String]
    
    var postTimeStamp: Timestamp
    
    var wardrobeItems: [WardrobeItemID]

}
