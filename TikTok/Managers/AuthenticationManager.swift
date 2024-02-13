//
//  AuthenticationManager.swift
//  TikTok
//
//  Created by Andrei Harnashevich on 13.02.24.
//

import Foundation
import FirebaseAuth

/// Manager responsible for signing in, up, and oout
final class AuthManager {
    /// Singleton instance of the manager
    public static let shared = AuthManager()
    
    /// Private constructor
    private init() {}
    
    /// Represents method to sign in
    enum SignInMethod {
        /// Email and password method
        case email
        /// Facebook method
        case facebook
        /// Google Account method
        case google
    }
    
    // Public
    
    public func signInWith(with mrthod: SignInMethod) {}
    
    public func signOut() {}
}
