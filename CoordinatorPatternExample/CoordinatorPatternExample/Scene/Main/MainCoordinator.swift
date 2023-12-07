//
//  MainCoordinator.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit
import Foundation

protocol MainCoordinatorFinishDelegate {
    func finishMainCoordinator()
}

final class MainCoordinator: Coordinator {
    
    // MARK: Property(s)
    
    var delegate: MainCoordinatorFinishDelegate?
    var childCoordinators: [UUID: Coordinator] = [:]
    
    let identifier: UUID = UUID()
    let navigationController: UINavigationController
    
    // MARK: Initializer(s)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: Function(s)
    
    func start() {
        let logOutButton = UIBarButtonItem(
            title: "Log Out",
            style: .done,
            target: self, action: #selector(didTapLogOutButton)
        )
        
        let mainContentViewController = MainContentViewController()
        mainContentViewController.navigationItem.rightBarButtonItem = logOutButton
        mainContentViewController.title = "Main"
        mainContentViewController.delegate = self
        
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.setViewControllers([mainContentViewController], animated: true)
    }
    
    @objc func didTapLogOutButton() {
        delegate?.finishMainCoordinator()
    }
}

extension MainCoordinator: MainContentSelectionDelegate {
    
    func didSelectItem(with index: Int) {
        let detailViewController = MainContentDetailViewController()
        detailViewController.configureName(with: String(index))
        
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
