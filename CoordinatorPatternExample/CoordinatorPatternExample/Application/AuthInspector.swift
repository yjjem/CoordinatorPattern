//
//  AuthInspector.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

final class AuthInspector {
    
    // MARK: Property(s)
    
    private let loginBase: UserDefaults = UserDefaults.standard
    private let isLoggedInKey: String = "isLoggedIn"
    
    // MARK: Initializer(s)
    
    init() {
        checkIsFirstLaunch()
    }
    
    // MARK: Function(s)
    
    func isLoggedIn() -> Bool {
        return loginBase.bool(forKey: isLoggedInKey)
    }
    
    // MARK: Private Function(s)
    
    private func checkIsFirstLaunch() {
        let isFirstLaunch = loginBase.bool(forKey: "launchedBefore")
        if isFirstLaunch {
            loginBase.register(defaults: [isLoggedInKey: false])
        }
    }
}
