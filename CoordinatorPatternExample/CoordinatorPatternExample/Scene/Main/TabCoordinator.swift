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
    
    private let window: UIWindow
    private let tabBarController: UITabBarController = .init()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: Function(s)
    
    func start() {
        configureTabController()
        window.rootViewController = tabBarController
    }
    
    // MARK: Private Function(s)
    
    private func configureTabController() {
        let listTab = makeListTab()
        var appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        tabBarController.tabBar.standardAppearance = appearance
        tabBarController.tabBar.scrollEdgeAppearance = appearance
        tabBarController.viewControllers = [listTab]
    }
    
    private func makeListTab() -> MainContentListViewController {
        let icon = UIImage(systemName: "list.bullet")
        let tabBarItem = UITabBarItem(title: "List", image: icon, selectedImage: icon)
        let contentListViewController = MainContentListViewController()
        contentListViewController.tabBarItem = tabBarItem
        
        let listCoordinator = MainContentCoordinator(rootController: contentListViewController)
        listCoordinator.start()
        childCoordinators[listCoordinator.identifier] = listCoordinator
        
        return contentListViewController
    }
}
