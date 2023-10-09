//
//  AppCoordinator.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: Property(s)
    
    var childCoordinators: [Coordinator] = []
    
    private var isLoggedIn: Bool = false
    
    private let window: UIWindow
    private let navigationController: UINavigationController
    
    //MARK: Initializer(s)
    
    init(window: UIWindow, navigationController: UINavigationController = .init() ) {
        self.window = window
        self.navigationController = navigationController
    }
    
    // MARK: Function(s)
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        if isLoggedIn {
            showMainFlow(on: navigationController)
        } else {
            showAuthenticationFlow(on: navigationController)
        }
    }
    
    func showMainFlow(on navigation: UINavigationController) {
        let mainFlowCoordinator = MainCoordinator(navigationController: navigation)
        mainFlowCoordinator.delegate = self
        mainFlowCoordinator.start()
    }
    
    func showAuthenticationFlow(on navigation: UINavigationController) {
        let authenticationFlowCoordinator = AuthenticationCoordinator(
            navigationController: navigation
        )
        authenticationFlowCoordinator.delegate = self
        authenticationFlowCoordinator.start()
    }
}

// MARK: AuthenticationCoordinatorFinishDelegate

extension AppCoordinator: AuthenticationCoordinatorFinishDelegate {
    
    func finishAuthenticationCoordinator() {
        showMainFlow(on: navigationController)
    }
}

// MARK: MainCoordinatorFinishDelegate

extension AppCoordinator: MainCoordinatorFinishDelegate {
    
    func finishMainCoordinator() {
        showAuthenticationFlow(on: navigationController)
    }
}