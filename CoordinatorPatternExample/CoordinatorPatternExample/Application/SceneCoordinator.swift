//
//  AppCoordinator.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class SceneCoordinator: Coordinator {
    
    // MARK: Property(s)
    
    var childCoordinators: [UUID: Coordinator] = [:]
    let identifier: UUID = UUID()
    
    private let window: UIWindow
    private let navigationController: UINavigationController
    private let authenticationInspector: AuthInspector = .init()
    
    //MARK: Initializer(s)
    
    init(window: UIWindow, navigationController: UINavigationController = .init()) {
        self.window = window
        self.navigationController = navigationController
    }
    
    // MARK: Function(s)
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        if authenticationInspector.isLoggedIn() {
            showTabBarFlow()
        } else {
            showAuthenticationFlow(on: navigationController)
        }
    }
    
    private func showTabBarFlow() {
        let tabBarCoordinator = TabCoordinator(window: window)
        tabBarCoordinator.delegate = self
        tabBarCoordinator.start()
        childCoordinators[tabBarCoordinator.identifier] = tabBarCoordinator
    }
    
    private func showAuthenticationFlow(on navigation: UINavigationController) {
        let authenticationFlowCoordinator = AuthCoordinator(navigationController: navigation)
        authenticationFlowCoordinator.delegate = self
        authenticationFlowCoordinator.start()
        childCoordinators[authenticationFlowCoordinator.identifier] = authenticationFlowCoordinator
    }
}

// MARK: AuthenticationCoordinatorFinishDelegate

extension SceneCoordinator: AuthCoordinatorFinishDelegate {
    
    func finishAuthenticationCoordinator(_ identifier: UUID) {
        childCoordinators.removeValue(forKey: identifier)
        showTabBarFlow()
    }
}

// MARK: TabCoordinatorFinishDelegate

extension SceneCoordinator: TabCoordinatorFinishDelegate {
    
    func didFinishWithLogOut(_ identifier: UUID) {
        childCoordinators.removeValue(forKey: identifier)
        showAuthenticationFlow(on: navigationController)
    }
}
