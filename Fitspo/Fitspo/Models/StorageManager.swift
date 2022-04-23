//
//  StorageManager.swift
//  Fitspo
//
//  Created by Noah Yin on 4/20/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Firebase
import UIKit

class StorageManager {
    
    static let shared = StorageManager()
   
    private let storage = Storage.storage()
    
    public enum StorageErrors: Error {
        case failedToUploadPhoto
        case failedToDownloadURL
    }
    
    public typealias UploadPictureCompletion = (Result<String, Error>) -> Void
    
    public func uploadProfilePicture(with image: UIImage, fileName: String, completion: @escaping UploadPictureCompletion) {
        
        let storageRef = storage.reference()
        
        let profilePicRef = storageRef.child("profilePics/\(fileName)_profile_picture.jpg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        guard let photoData = image.jpegData(compressionQuality: 0.5) else {
            print("error couldn't convert photo")
            return
        }
        
        let uploadTask = profilePicRef.putData(photoData, metadata: metadata) { metadata, error in
            guard error == nil else {
                print("failed to upload photo to cloud storage")
                completion(.failure(StorageErrors.failedToUploadPhoto))
                return
            }
        }
        
        uploadTask.observe(.success) { snapshot in
            profilePicRef.downloadURL { url, error in
                guard let downURL = url else {
                    print("failed to download photo URL")
                    completion(.failure(StorageErrors.failedToDownloadURL))
                    return
                }
                let strURL = downURL.absoluteString
                print("photo URL download success")
                completion(.success(strURL))
            }
        }
    }
    
}
