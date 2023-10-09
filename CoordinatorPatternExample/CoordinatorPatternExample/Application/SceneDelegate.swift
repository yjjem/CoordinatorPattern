//
//  SceneDelegate.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: Property(s)
    
    var window: UIWindow?
    
    // MARK: Function(s)
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        let sceneCoordinator = AppCoordinator(window: window)
        sceneCoordinator.start()
    }
}
