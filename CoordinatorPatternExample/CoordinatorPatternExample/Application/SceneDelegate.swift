//
//  SceneDelegate.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: Property(s)
    
    var window: UIWindow?
    private var coordinator: SceneCoordinator?
    
    // MARK: Function(s)
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()
        self.window = window

        let sceneCoordinator = SceneCoordinator(window: window)
        sceneCoordinator.start()
        self.coordinator = sceneCoordinator
    }
}
