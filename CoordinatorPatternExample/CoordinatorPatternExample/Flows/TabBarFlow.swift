//
//  TabBarFlow.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2024 Jeremy All rights reserved.
    

import UIKit
import RxFlow

final class TabBarFlow: Flow {
    
    var root: Presentable {
        return tabBarController
    }
    
    var initialStep: Step {
        return FlowSteps.tabBar
    }
    
    private lazy var tabBarController: UITabBarController = {
        let tabBarController = UITabBarController()
        let defaultAppearance = UITabBarAppearance()
        defaultAppearance.configureWithDefaultBackground()
        tabBarController.tabBar.standardAppearance = defaultAppearance
        tabBarController.tabBar.scrollEdgeAppearance = defaultAppearance
        return tabBarController
    }()
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? FlowSteps else { return .none }
        
        switch step {
        case .tabBar:
            return showTabBarFlow()
        default: 
            return .none
        }
    }
    
    // MARK: Private Function(s)
    
    private func showTabBarFlow() -> FlowContributors {
        let numbersView = MainContentListViewController()
        numbersView.tabBarItem = TabTypes.numbers.tabBarItem
        tabBarController.setViewControllers([numbersView], animated: true)
        return .one(flowContributor: .contribute(withNext: numbersView))
    }
}
