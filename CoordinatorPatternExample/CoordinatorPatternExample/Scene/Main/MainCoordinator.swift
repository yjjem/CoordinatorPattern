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
    
    private let navigationController: UINavigationController
    private let authenticator: Authenticator = Authenticator()
    
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
        mainContentViewController.itemSelectionDelegate = self
        navigationController.setViewControllers([mainContentViewController], animated: true)
        
        let mainContentCoordinator = MainContentCoordinator(
            rootController: mainContentViewController
        )
        mainContentCoordinator.start()
        mainContentCoordinator.delegate = self
    }
    
    private func showDetailFlow(of content: MainContent) {
        let detailViewController = MainContentDetailViewController()
        detailViewController.configureWithContentItem(content: content)
        navigationController.pushViewController(detailViewController, animated: true)
    }
}

// MARK: MainProfileViewControllerDelegate

extension MainCoordinator: MainProfileViewControllerDelegate {
    
    func didTapLogOutButton() {
        authenticator.logOut()
        delegate?.finishMainCoordinator(identifier)
    }
}

// MARK: MainContentSelectionDelegate

extension MainCoordinator: MainContentItemSelectionDelegate {
    
    func didSelectItem(_ item: MainContent) {
        showDetailFlow(of: item)
    }
}

// MARK: MainContentCoordinatorDelegate

extension MainCoordinator: MainContentCoordinatorDelegate {
    
    func didFinishWithLogOut(_ identifier: UUID) {
        childCoordinators.removeAll()
        delegate?.finishMainCoordinator(identifier)
    }
}
