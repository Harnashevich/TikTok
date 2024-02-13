//
//  StorageManager.swift
//  TikTok
//
//  Created by Andrei Harnashevich on 13.02.24.
//

import Foundation
import FirebaseStorage

/// Managre object that deals with firebase storage
final class StorageManager {
    /// Singleton instance
    public static let shared = StorageManager()
    
    /// Storage bucket reference
    private let database = Storage.storage().reference()
    
    /// Private constructor
    private init() {}
    
    // Public
    
    public func getVideoURL(with identfier: String, completion: (URL) -> Void) {
    }
    
    public func uploadVideoURL(from url: URL) {
    }
}
