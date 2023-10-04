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
        mainContentViewController.title = "Main"
        mainContentViewController.delegate = self
        
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.setViewControllers([mainContentViewController], animated: true)
    }
}

extension MainCoordinator: MainContentSelectionDelegate {
    
    func didSelectItem(with index: Int) {
        let detailViewController = MainContentDetailViewController()
        detailViewController.configureName(with: String(index))
        
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
