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
    private let authenticationInspector: AuthInspector = .init()
    
    //MARK: Initializer(s)
    
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: Function(s)
    
    func start() {
        if authenticationInspector.isLoggedIn() {
            showTabBarFlow()
        } else {
            showAuthenticationFlow()
        }
    }
    
    // MARK: Private Function(s)
    
    private func showTabBarFlow() {
        let tabBarCoordinator = TabBarCoordinator(window: window)
        tabBarCoordinator.delegate = self
        tabBarCoordinator.start()
        addChild(coordinator: tabBarCoordinator)
    }
    
    private func showAuthenticationFlow() {
        let authenticationFlowCoordinator = AuthCoordinator(window: window)
        authenticationFlowCoordinator.delegate = self
        authenticationFlowCoordinator.start()
        addChild(coordinator: authenticationFlowCoordinator)
    }
}

// MARK: AuthenticationCoordinatorFinishDelegate

extension SceneCoordinator: AuthCoordinatorFinishDelegate {
    
    func finishAuthenticationCoordinator(_ sender: Coordinator) {
        removeChild(coordinator: sender)
        showTabBarFlow()
    }
}

// MARK: TabCoordinatorFinishDelegate

extension SceneCoordinator: TabBarCoordinatorFinishDelegate {
    
    func didFinishWithLogOut(_ sender: Coordinator) {
        removeChild(coordinator: sender)
        showAuthenticationFlow()
    }
}
