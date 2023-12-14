//
//  TabBarCoordinator.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

protocol TabBarCoordinatorFinishDelegate {
    func didFinishWithLogOut(_ identifier: UUID)
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
    
    private func makeProfileTab() -> MainProfileViewController {
        let icon = UIImage(systemName: "person.crop.circle")
        let tabBarItem = UITabBarItem(title: "Profile", image: icon, selectedImage: icon)
        let profileViewController = MainProfileViewController()
        profileViewController.tabBarItem = tabBarItem
        profileViewController.delegate = self
        return profileViewController
    }
}

// MARK: MainProfileViewControllerDelegate

extension TabBarCoordinator: MainProfileViewControllerDelegate {
    
    func didTapLogOutButton() {
        delegate?.didFinishWithLogOut(identifier)
    }
}
