//
//  SceneFlow.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2024 Jeremy All rights reserved.


import UIKit
import RxFlow
import RxRelay

final class SceneFlow: Flow {
    
    // MARK: Property(s)
    
    var root: Presentable {
        return rootViewController
    }
    
    private lazy var rootViewController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        return navigationController
    }()
    
    // MARK: Function(s)
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? FlowSteps else { return .none }
        
        switch step {
        case .auth:
            return showAuthFlow()
        case .tabBar:
            return showTabBarFlow()
        case .finishAuth:
            return dismissAuth()
        default:
            return .none
        }
    }
    
    // MARK: Private Function(s)
    
    private func showAuthFlow() -> FlowContributors {
        let authFlow = AuthFlow()
        Flows.use(authFlow, when: .ready) { [weak rootViewController] flowRoot in
            flowRoot.modalPresentationStyle = .fullScreen
            flowRoot.modalTransitionStyle = .crossDissolve
            DispatchQueue.main.async {
                rootViewController?.present(flowRoot, animated: true)
            }
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: authFlow,
            withNextStepper: OneStepper(withSingleStep: authFlow.initialStep))
        )
    }
    
    private func showTabBarFlow() -> FlowContributors {
        let tabBarFlow = TabBarFlow()
        Flows.use(tabBarFlow, when: .ready) { flowRoot in
            flowRoot.modalPresentationStyle = .fullScreen
            flowRoot.modalTransitionStyle = .crossDissolve
            self.rootViewController.present(flowRoot, animated: true)
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: tabBarFlow,
            withNextStepper: OneStepper(withSingleStep: tabBarFlow.initialStep))
        )
    }
    
    private func dismissAuth() -> FlowContributors {
        if let auth = rootViewController.presentedViewController {
            auth.dismiss(animated: true)
        }
        return .one(flowContributor: .forwardToCurrentFlow(withStep: FlowSteps.tabBar))
    }
}
