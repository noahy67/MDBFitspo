//
//  DatabaseRequest.swift
//  Fitspo
//
//  Created by Noah Yin on 4/17/22.
//

import Foundation
import FirebaseFirestore

class DatabaseRequest {
    
    static let shared = DatabaseRequest()
    
    let db = Firestore.firestore()
    
    private var userListener: ListenerRegistration?
    
    func setUser(_ user: User, completion: (()->Void)?) {
        guard let uid = user.uid else { return }
        do {
            try db.collection("users").document(uid).setData(from: user)
            completion?()
            
        }
        catch {
            print("fuck you")
        }
    }
    
    
    func setPost(_ post: Post, completion: (()->Void)?) {
        guard let id = post.id else { return }

        do {
            try db.collection("posts").document(id).setData(from: post)
            completion?()
        } catch { }
    }
    
    func getProfilePosts(vc: ProfileVC)->[Post] {
        var posts: [Post] = []
        if (AuthManager.shared.isSignedIn()) {
            userListener = db.collection("posts").order(by: "startTimeStamp", descending: true)
                .addSnapshotListener { querySnapshot, error in
                posts = []
                guard let documents = querySnapshot?.documents else { return }
                for document in documents {
                    guard let post = try? document.data(as: Post.self) else { return }
                    posts.append(post)
                }
//                vc.reloadEvents(new: posts)
            }
        }
        return posts
    }
    

}
