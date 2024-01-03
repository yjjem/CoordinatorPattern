//
//  MainCoordinator.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit
import Foundation

protocol MainCoordinatorFinishDelegate: AnyObject {
    func finishMainCoordinator(_ identifier: UUID)
}

final class MainCoordinator: Coordinator {
    
    // MARK: Property(s)
    
    weak var delegate: MainCoordinatorFinishDelegate?
    var childCoordinators: [UUID: Coordinator] = [:]
    
    let identifier: UUID = UUID()
    
    private let navigationController: UINavigationController
    private let authenticator: AuthPerformer = AuthPerformer()
    
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
        let mainContentViewController = MainContentListViewController()
        mainContentViewController.itemSelectionDelegate = self
        navigationController.setViewControllers([mainContentViewController], animated: true)
        
        let mainContentCoordinator = MainContentCoordinator(
            rootController: mainContentViewController
        )
        mainContentCoordinator.start()
        mainContentCoordinator.delegate = self
        childCoordinators[mainContentCoordinator.identifier] = mainContentCoordinator
    }
    
    private func showDetailFlow(of content: MainContent) {
        let detailViewController = MainContentDetailViewController()
        detailViewController.configureWithContentItem(content: content)
        navigationController.pushViewController(detailViewController, animated: true)
    }
}

// MARK: MainContentSelectionDelegate

extension MainCoordinator: MainContentListItemSelectionDelegate {
    
    func didSelectItem(_ item: MainContent) {
        showDetailFlow(of: item)
    }
}

// MARK: MainContentCoordinatorDelegate

extension MainCoordinator: MainContentCoordinatorDelegate {
    
    func didFinishWithLogOut(_ identifier: UUID) {
        childCoordinators.removeValue(forKey: identifier)
        delegate?.finishMainCoordinator(self.identifier)
    }
}
