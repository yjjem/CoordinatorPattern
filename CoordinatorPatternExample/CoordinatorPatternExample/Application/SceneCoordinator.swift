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
        window.rootViewController = showMainFlow()
        window.makeKeyAndVisible()
    }
    
    func showMainFlow() -> UINavigationController {
        let mainFlowNavigation = UINavigationController()
        let mainFlowCoordinator = MainCoordinator(navigationController: mainFlowNavigation)
        mainFlowCoordinator.start()
        
        return mainFlowNavigation
    }
}
