//
//  DatabaseManager.swift
//  TikTok
//
//  Created by Andrei Harnashevich on 13.02.24.
//

import Foundation
import FirebaseDatabase

/// Manager to interact with database
final class DatabaseManager {
    /// Singleton instance
    public static let shared = DatabaseManager()
    
    /// Database refernece
    private let database = Database.database().reference()
    
    /// Private constructor
    private init() {}
    
    // Public
    
    public func getAllUsers(completion: ([String]) -> Void) {
        
    }
}
