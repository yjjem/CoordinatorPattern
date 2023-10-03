//
//  MainCoordinator.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit
import Foundation

final class MainCoordinator: Coordinator {
    
    // MARK: Property(s)
    
    var childCoordinators: [Coordinator] = []
    
    let navigationController: UINavigationController
    
    // MARK: Initializer(s)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: Function(s)
    
    func start() {
        let mainContentViewController = MainContentViewController()
        mainContentViewController.configureName(with: "Main")
        navigationController.viewControllers = [mainContentViewController]
    }
}
