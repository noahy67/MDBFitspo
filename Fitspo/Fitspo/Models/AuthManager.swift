//
//  AuthManager.swift
//  Fitspo
//
//  Created by Noah Yin on 4/17/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthManager {
    
    static let shared = AuthManager()
    
    let auth = Auth.auth()
    
    enum SignInErrors: Error {
        case wrongPassword
        case userNotFound
        case invalidEmail
        case internalError
        case errorFetchingUserDoc
        case errorDecodingUserDoc
        case unspecified
    }
    
    enum SignUpErrors: Error {
        case emailAlreadyInUse
        case weakPassword
        case internalError
        case errorFetchingUserDoc
        case errorDecodingUserDoc
        case unspecified
    }
    let db = Firestore.firestore()
    
    var currentUser: User?
    
    var userInfo: User?
    
    private var userListener: ListenerRegistration?
    
    init() {
        guard let user = auth.currentUser else { return }
        
        linkUser(withuid: user.uid, completion: nil)
    }
    
    func signIn(withEmail email: String, password: String,
                completion: ((Result<User, SignInErrors>)->Void)?) {
        
        auth.signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                let nsError = error as NSError
                let errorCode = FirebaseAuth.AuthErrorCode(rawValue: nsError.code)
                
                switch errorCode {
                case .wrongPassword:
                    completion?(.failure(.wrongPassword))
                case .userNotFound:
                    completion?(.failure(.userNotFound))
                case .invalidEmail:
                    completion?(.failure(.invalidEmail))
                default:
                    completion?(.failure(.unspecified))
                }
                return
            }
            guard let authResult = authResult else {
                completion?(.failure(.internalError))
                return
            }
            
            self?.linkUser(withuid: authResult.user.uid, completion: completion)
        }
    }
    
    /* TODO: Firebase sign up handler, add user to firestore */
    func signUp(withEmail email: String, password: String, name: String, username: String,
                completion: ((Result<User, SignUpErrors>)->Void)?) {
        
        auth.createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                let nsError = error as NSError
                let errorCode = FirebaseAuth.AuthErrorCode(rawValue: nsError.code)
                
                switch errorCode {
                case .emailAlreadyInUse:
                    completion?(.failure(.emailAlreadyInUse))
                case .weakPassword:
                    completion?(.failure(.weakPassword))
                default:
                    completion?(.failure(.unspecified))
                }
                return
            }
            guard let authResult = authResult else {
                completion?(.failure(.internalError))
                
                return
            }
            
            let input: User = User(uid: authResult.user.uid, username: username, email: email, fullname: name, userBio: "", photoURL: "gs://fitspo-a9673.appspot.com/profilePics/no-profile-image.png", allPosts: [], friends: [], savedPosts: [], userWardrobe: [])
            DatabaseRequest.shared.setUser(input) { () }
            self?.linkUser2(withuid: authResult.user.uid, completion: completion)
        }
        
        
        
        
        // pass in all sign up variables
        // Create User
        // setUser
        // copyLink User
    }
    
    func isSignedIn() -> Bool {
        return auth.currentUser != nil
    }
    
    func signOut(completion: (()->Void)? = nil) {
        do {
            try auth.signOut()
            unlinkCurrentUser()
            completion?()
        } catch { }
    }
    
    private func linkUser(withuid uid: String,
                          completion: ((Result<User, SignInErrors>)->Void)?) {
        
        userListener = db.collection("users").document(uid).addSnapshotListener { [weak self] docSnapshot, error in
            guard let document = docSnapshot else {
                completion?(.failure(.errorFetchingUserDoc))
                return
            }
            guard let user = try? document.data(as: User.self) else {
                completion?(.failure(.errorDecodingUserDoc))
                return
            }
            self?.currentUser = user
            completion?(.success(user))
        }
    }
    
    private func linkUser2(withuid uid: String,
                          completion: ((Result<User, SignUpErrors>)->Void)?) {
        
        userListener = db.collection("users").document(uid).addSnapshotListener { [weak self] docSnapshot, error in
            guard let document = docSnapshot else {
                completion?(.failure(.errorFetchingUserDoc))
                return
            }
            guard let user = try? document.data(as: User.self) else {
                completion?(.failure(.errorDecodingUserDoc))
                return
            }
            
            self?.currentUser = user
            completion?(.success(user))
        }
    }
    
    private func unlinkCurrentUser() {
        userListener?.remove()
        currentUser = nil
    }
    
//    func getUserData()->User {
//        let uid = auth.currentUser?.uid
//        userInfo = User(uid: uid, username: "dddd", email: "", fullname: "", userBio: "", photoURL: "", allPosts: [], friends: [], savedPosts: [], userWardrobe: [])
//
//        userListener = db.collection("users").addSnapshotListener {
//            docSnapshot, error in
//            guard let documents = docSnapshot?.documents else { return }
//
////            for document in documents {
////                guard let userDum = try? document.data(as: User.self) else { return }
////                if userDum.uid == uid {
////                    self.userInfo?.username = "testing"
////                }
////            }
//
//
//            self.userInfo?.username = "testing"
//
//
////            user.username = document.value(forKey: "username") as! String
////            if let dictionary = document.data() {
////                user.username = dictionary["username"] as! String
////                user.email = dictionary["email"] as! String
////                user.fullname = dictionary["fullname"] as! String
////                user.userBio = dictionary["userBio"] as! String
////                user.email = dictionary["email"] as! String
////                user.photoURL = dictionary["photoURL"] as! String
//
//
////            }
//
//
//
//        }
//        return userInfo!
//    }
}


