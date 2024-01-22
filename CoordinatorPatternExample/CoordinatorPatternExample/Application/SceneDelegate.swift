//
//  SceneDelegate.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit
import RxFlow

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: Property(s)
    
    var window: UIWindow?
    private let coordinator: FlowCoordinator = FlowCoordinator()
    private lazy var sceneFlow = {
        return SceneFlow()
    }()
    
    // MARK: Function(s)
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        Flows.use(sceneFlow, when: .ready) { [weak window] flowRoot in
            window?.rootViewController = flowRoot
            window?.makeKeyAndVisible()
        }
    
        coordinator.coordinate(
            flow: sceneFlow,
            with: OneStepper(withSingleStep: FlowSteps.auth)
        )
    }
}
