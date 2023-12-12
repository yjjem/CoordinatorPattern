//
//  TabCoordinator.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class TabCoordinator: Coordinator {
    
    // MARK: Property(s)
    
    var childCoordinators: [UUID : Coordinator] = [:]
    let identifier: UUID = UUID()
    
    private let navigationController: UINavigationController
    private let tabBarController: UITabBarController = {
        let tabController = UITabBarController()
        return tabController
    }()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: Function(s)
    
    func start() {
        configureTabController()
        navigationController.setViewControllers([tabBarController], animated: true)
    }
    
    // MARK: Private Function(s)
        
    private func configureTabController() {
        let listTab = makeListTab()
        let tabViewControllers: [UIViewController] = [listTab]
        tabBarController.setViewControllers(tabViewControllers, animated: true)
    }
    
    private func makeListTab() -> MainContentListViewController {
        let icon = UIImage(systemName: "list.bullet")
        let tabBarItem = UITabBarItem(title: "List", image: icon, selectedImage: nil)
        let contentListViewController = MainContentListViewController()
        contentListViewController.tabBarItem = tabBarItem
        
        let listCoordinator = MainContentCoordinator(rootController: contentListViewController)
        listCoordinator.start()
        childCoordinators[listCoordinator.identifier] = listCoordinator
        
        return contentListViewController
    }
}
