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
    
    func setWardrobeItem(_ wardrobe: WardrobeItem, completion: (()->Void)?) {
        guard let id = wardrobe.id else { return }

        do {
            try db.collection("wardrobeItems").document(id).setData(from: wardrobe)
            completion?()
        } catch { }
    }
    
    func getProfilePosts(vc: ProfileVC)->[Post] {
        var posts: [Post] = []
        if (AuthManager.shared.isSignedIn()) {
            userListener = db.collection("posts").order(by: "postTimeStamp", descending: true)
                .addSnapshotListener { querySnapshot, error in
                posts = []
                guard let documents = querySnapshot?.documents else { return }
                for document in documents {
                    guard let post = try? document.data(as: Post.self) else { continue }
                    if post.photos != "" && post.creator == AuthManager.shared.currentUser?.uid {
                        posts.append(post)
                    }
                }
                vc.reloadProfile(new: posts)
            }
        }
        return posts
    }
    
    func getWardrobeItems(vc: WardrobeVC, creatorURL: String)->[WardrobeItem] {
        var wardrobe: [WardrobeItem] = []
        if (AuthManager.shared.isSignedIn()) {
            userListener = db.collection("wardrobeItems").order(by: "postTimeStamp", descending: true)
                .addSnapshotListener { querySnapshot, error in
                wardrobe = []
                guard let documents = querySnapshot?.documents else { return }
                for document in documents {
                    guard let item = try? document.data(as: WardrobeItem.self) else { continue }
                    print("GETTING WARDROBE STUFF: \(item.photoURL)")
                    if item.photoURL != "" && item.creator == creatorURL {
                        wardrobe.append(item)
                    }
                }
                vc.reloadWardrobe(new: wardrobe)
            }
        }
        return wardrobe
    }
    
    func getFeedPosts(vc: HomeVC)->[Post] {
        var posts: [Post] = []
        if (AuthManager.shared.isSignedIn()) {
            userListener = db.collection("posts").order(by: "postTimeStamp", descending: true)
                .addSnapshotListener { querySnapshot, error in
                posts = []
                guard let documents = querySnapshot?.documents else { return }
                for document in documents {
                    guard let post = try? document.data(as: Post.self) else { continue }
                    if post.photos != "" {
                        posts.append(post)
                    }
                    
                }
                vc.reloadProfile(new: posts)
            }
        }
        return posts
    }
    
    func getUserData(cell: HomePostCell, creatorURL: String)->User {
        var userInfo: User = User(uid: creatorURL, username: "", email: "'", fullname: "", userBio: "", photoURL: "", allPosts: [], friends: [], savedPosts: [], userWardrobe: [])
        
        if (AuthManager.shared.isSignedIn()) {
            userListener = db.collection("users").document(creatorURL).addSnapshotListener(
                { querySnapshot, error in
                    
                    userInfo = User(uid: creatorURL, username: "", email: "'", fullname: "", userBio: "", photoURL: "", allPosts: [], friends: [], savedPosts: [], userWardrobe: [])
                    
                    guard let query = querySnapshot else { return }
                    
                    guard let newUser = try? query.data(as: User.self) else { return }
                        
                    userInfo = newUser
                    
                    cell.getProfilePhotoURL(new: userInfo)
            })
        }
        return userInfo
    }
    

}
