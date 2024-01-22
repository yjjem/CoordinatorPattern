//
//  AuthFlow.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2024 Jeremy All rights reserved.
    

import UIKit
import RxFlow

final class AuthFlow: Flow {
    
    // MARK: Property(s)
    
    var root: Presentable {
        return navigationController
    }
    
    private let navigationController: UINavigationController = {
        let navigation = UINavigationController()
        navigation.modalPresentationStyle = .fullScreen
        return navigation
    }()
    
    // MARK: Function(s)
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? FlowSteps else { return .none }
        
        switch step {
        case .selectAuthService:
            return showAuthFlow()
        case .enterAuth(let type):
            return showAuthEntry(serviceType: type)
        case .finishAuth:
            return .end(forwardToParentFlowWithStep: FlowSteps.tabBar)
        default:
            return .none
        }
    }
    
    // MARK: Private Function(s)
    
    private func showAuthFlow() -> FlowContributors {
        let authViewController = AuthServiceSelectorViewController()
        navigationController.pushViewController(authViewController, animated: true)
        return .one(flowContributor: .contribute(withNext: authViewController))
    }
    
    private func showAuthEntry(serviceType: AuthServiceType) -> FlowContributors {
        let authEntryViewController = AuthUserEntryViewController()
        authEntryViewController.configureWith(serviceType)
        navigationController.pushViewController(authEntryViewController, animated: true)
        return .one(flowContributor: .contribute(withNext: authEntryViewController))
    }
}
