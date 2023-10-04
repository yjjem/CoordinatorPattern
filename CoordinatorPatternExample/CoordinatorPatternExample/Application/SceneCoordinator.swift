//
//  AppCoordinator.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

final class SceneCoordinator: Coordinator {
    
    // MARK: Property(s)
    
    var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    private let navigationController: UINavigationController
    
    private var isLoggedIn: Bool = false
    
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

extension SceneCoordinator: AuthenticationCoordinatorFinishDelegate {
    
    func finish() {
        showMainFlow(on: navigationController)
    }
}
