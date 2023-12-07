//
//  MainCoordinator.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit
import Foundation

protocol MainCoordinatorFinishDelegate {
    func finishMainCoordinator(_ identifier: UUID)
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
        showMainFlow()
    }
    
    // MARK: Private Function(s)
    
    private func showMainFlow() {
        let mainContentViewController = MainContentViewController()
        mainContentViewController.delegate = self
        navigationController.setViewControllers([mainContentViewController], animated: true)
    }
    
    private func showProfileFlow() {
        let profileViewController = MainProfileViewController()
        profileViewController.delegate = self
        navigationController.pushViewController(profileViewController, animated: true)
    }
}

// MARK: MainProfileViewControllerDelegate

extension MainCoordinator: MainProfileViewControllerDelegate {
    
    func didTapLogOutButton() {
        delegate?.finishMainCoordinator(identifier)
    }
}

// MARK: MainContentSelectionDelegate

extension MainCoordinator: MainContentSelectionDelegate {
    
    func didSelectItem(with index: Int) {
        let detailViewController = MainContentDetailViewController()
        detailViewController.configureName(with: String(index))
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func didTapFilterButton() {
        
    }
    
    func didTapProfileButton() {
        showProfileFlow()
    }
}
