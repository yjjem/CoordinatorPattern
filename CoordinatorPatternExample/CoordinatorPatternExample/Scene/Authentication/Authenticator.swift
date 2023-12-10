//
//  Authenticator.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

final class Authenticator {
    
    // MARK: Property(s)
    
    private let authenticator = UserDefaults.standard
    private let isLoggedInKey: String = "isLoggedIn"
    
    // MARK: Function(s)
    
    func logIn() {
        authenticator.set(true, forKey: isLoggedInKey)
    }
    
    func logOut() {
        authenticator.set(false, forKey: isLoggedInKey)
    }
}
