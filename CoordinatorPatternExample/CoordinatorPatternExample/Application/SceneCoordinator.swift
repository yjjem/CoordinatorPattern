//
//  AppCoordinator.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

final class SceneCoordinator: Coordinator {
    
    // MARK: Property(s)
    
    var childCoordinators: [Coordinator] = []
    let window: UIWindow
    
    //MARK: Initializer(s)
    
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: Function(s)
    
    func start() {
        let viewController = MainContentViewController()
        let mainFlowNavigation = UINavigationController(rootViewController: viewController)
        window.rootViewController = mainFlowNavigation
        window.makeKeyAndVisible()
    }
}
