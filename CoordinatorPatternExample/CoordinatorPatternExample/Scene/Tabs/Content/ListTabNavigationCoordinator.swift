//
//  ListTabCoordinator.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

protocol ListTabNavigationCoordinatorFinishDelegate {
    func didFinish(coordinator: CoordinatorProtocol)
}

final class ListTabNavigationCoordinator: CoordinatorProtocol {
    
    // MARK: Variable(s)
    
    var delegate: ListTabNavigationCoordinatorFinishDelegate?
    var childCoordinators: [UUID : CoordinatorProtocol] = [:]
    let identifier: UUID = UUID()
    
    private let navigationController: UINavigationController
    private let rootController: MainContentListViewController = .init()
    
    // MARK: Initializer(s)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: Function(s)
    
    func start() {
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
        listCoordinator.delegate = self
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

// MARK: MainContentCoordinatorDelegate

extension ListTabNavigationCoordinator: MainContentCoordinatorDelegate {
    func didFinishWithLogOut(_ coordinator: CoordinatorProtocol) {
        removeChild(coordinator: coordinator)
        delegate?.didFinish(coordinator: self)
    }
}
