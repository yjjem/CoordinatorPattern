//
//  TabBarCoordinator.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

protocol TabBarCoordinatorFinishDelegate {
    func didFinishWithLogOut(_ sender: Coordinator)
}

final class TabBarCoordinator: Coordinator {
    
    // MARK: Property(s)
    
    var delegate: TabBarCoordinatorFinishDelegate?
    var childCoordinators: [UUID : Coordinator] = [:]
    let identifier: UUID = UUID()
    
    private let window: UIWindow
    private let tabBarController: UITabBarController = .init()
    
    // MARK: Initializer(s)
    
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
        let profileTab = makeProfileTab()
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        tabBarController.tabBar.standardAppearance = appearance
        tabBarController.tabBar.scrollEdgeAppearance = appearance
        tabBarController.viewControllers = [listTab, profileTab]
    }
    
    private func makeListTab() -> UINavigationController {
        let listTabNavigation = UINavigationController()
        listTabNavigation.tabBarItem = TabTypes.list.tabBarItem
        let listCoordinator = ListTabNavigationCoordinator(navigationController: listTabNavigation)
        listCoordinator.delegate = self
        listCoordinator.start()
        addChild(coordinator: listCoordinator)
        return listTabNavigation
    }
    
    private func makeProfileTab() -> MainProfileViewController {
        let profileViewController = MainProfileViewController()
        profileViewController.tabBarItem = TabTypes.profile.tabBarItem
        profileViewController.delegate = self
        return profileViewController
    }
}

// MARK: MainProfileViewControllerDelegate

extension TabBarCoordinator: MainProfileViewControllerDelegate {
    
    func didTapLogOutButton() {
        delegate?.didFinishWithLogOut(self)
    }
}

// MARK: ListTabNavigationCoordinatorFinishDelegate

extension TabBarCoordinator: ListTabNavigationCoordinatorFinishDelegate {
    
    func didFinish(coordinator: Coordinator) {
        removeChild(coordinator: coordinator)
        delegate?.didFinishWithLogOut(self)
    }
}
