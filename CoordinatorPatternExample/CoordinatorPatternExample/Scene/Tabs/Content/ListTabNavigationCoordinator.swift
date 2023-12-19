//
//  ListTabCoordinator.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

protocol ListTabNavigationCoordinatorFinishDelegate {
    func didFinish(coordinator: CoordinatorProtocol)
}

final class ListTabNavigationCoordinator: Coordinator {
    
    // MARK: Variable(s)
    
    var delegate: ListTabNavigationCoordinatorFinishDelegate?
    
    private let navigationController: UINavigationController
    
    // MARK: Initializer(s)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: Function(s)
    
    override func start() {
        showMainFlow()
    }
    
    // MARK: Private Function(s)
    
    private func showMainFlow() {
        let mainListViewController = MainContentListViewController()
        mainListViewController.itemSelectionDelegate = self
        let mainListCoordinator = MainContentCoordinator(rootController: mainListViewController)
        mainListCoordinator.start()
        addChild(coordinator: mainListCoordinator)
        navigationController.pushViewController(mainListViewController, animated: true)
    }
    
    private func showDetailFlow(content: MainContent) {
        let detailViewController = MainContentDetailViewController()
        detailViewController.configureWithContentItem(content: content)
        navigationController.pushViewController(detailViewController, animated: true)
    }
}

// MARK: MainContentListItemSelectionDelegate

extension ListTabNavigationCoordinator: MainContentListItemSelectionDelegate {
    func didSelectItem(_ item: MainContent) {
        showDetailFlow(content: item)
    }
}
