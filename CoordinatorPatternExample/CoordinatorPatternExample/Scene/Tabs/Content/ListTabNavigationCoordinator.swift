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
    private let rootController: MainContentListViewController = .init()
    
    // MARK: Initializer(s)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: Function(s)
    
    override func start() {
        rootController.itemSelectionDelegate = self
        configureListCoordinator()
        configureNavigationController()
    }
    
    // MARK: Private Function(s)
    
    private func showDetailFlow(content: MainContent) {
        let detailViewController = MainContentDetailViewController()
        detailViewController.configureWithContentItem(content: content)
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    private func configureNavigationController() {
        navigationController.setViewControllers([rootController], animated: false)
    }
    
    private func configureListCoordinator() {
        let listCoordinator = MainContentCoordinator(rootController: rootController)
        listCoordinator.start()
        addChild(coordinator: listCoordinator)
    }
}

// MARK: MainContentListItemSelectionDelegate

extension ListTabNavigationCoordinator: MainContentListItemSelectionDelegate {
    func didSelectItem(_ item: MainContent) {
        showDetailFlow(content: item)
    }
}
