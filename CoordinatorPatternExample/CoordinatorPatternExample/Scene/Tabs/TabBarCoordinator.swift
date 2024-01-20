//
//  TabBarCoordinator.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

protocol TabBarCoordinatorFinishDelegate: AnyObject {
    func didFinishWithLogOut(_ sender: CoordinatorProtocol)
}

final class TabBarCoordinator: Coordinator {
    
    // MARK: Property(s)
    
    weak var delegate: TabBarCoordinatorFinishDelegate?
    
    private let window: UIWindow
    private let tabBarController: UITabBarController = .init()
    
    // MARK: Initializer(s)
    
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: Function(s)
    
    override func start() {
        configureTabController()
        window.rootViewController = tabBarController
    }
    
    // MARK: Private Function(s)
    
    private func configureTabController() {
        let listTab = makeListTab()
        let profileTab = makeProfileTab()
        let browseTab = makeBrowseTab()
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        tabBarController.tabBar.standardAppearance = appearance
        tabBarController.tabBar.scrollEdgeAppearance = appearance
        tabBarController.viewControllers = [listTab, browseTab, profileTab]
    }
    
    private func makeListTab() -> UINavigationController {
        let listTabNavigation = UINavigationController()
        listTabNavigation.tabBarItem = TabTypes.numbers.tabBarItem
        let listCoordinator = ListTabNavigationCoordinator(navigationController: listTabNavigation)
        listCoordinator.start()
        addChild(coordinator: listCoordinator)
        return listTabNavigation
    }

    private func makeBrowseTab() -> UINavigationController {
        let browseTabNavigation = UINavigationController()
        browseTabNavigation.tabBarItem = TabTypes.browse.tabBarItem
        let browseCoordinator = BrowseCategoryTabCoordinator(navigationController: browseTabNavigation)
        browseCoordinator.start()
        addChild(coordinator: browseCoordinator)
        return browseTabNavigation
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
        sendFlowEvent(#selector(LogOutEvent.didLogOut))
    }
}
