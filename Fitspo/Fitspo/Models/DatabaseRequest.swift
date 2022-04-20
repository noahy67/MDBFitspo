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
    
    
//    func setEvent(_ event: Event, completion: (()->Void)?) {
//        guard let id = event.id else { return }
//
//        do {
//            try db.collection("events").document(id).setData(from: event)
//            completion?()
//        } catch { }
//    }
    
//    func getEvents(vc: ProfileVC)->[Event] {
//        var events: [Event] = []
//        if (AuthManager.shared.isSignedIn()) {
//            userListener = db.collection("events").order(by: "startTimeStamp", descending: true)
//                .addSnapshotListener { querySnapshot, error in
//                events = []
//                guard let documents = querySnapshot?.documents else { return }
//                for document in documents {
//                    guard let event = try? document.data(as: Event.self) else { return }
//                    events.append(event)
//                }
//                vc.reloadEvents(new: events)
//            }
//        }
//        return events
//    }
    

}
