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
            return .none
        default:
            return .none
        }
    }
    
    // MARK: Private Function(s)
    
    private func showAuthFlow() -> FlowContributors {
        let authFlow = AuthFlow()
        Flows.use(authFlow, when: .created) { [weak rootViewController] flowRoot in
            rootViewController?.present(flowRoot, animated: false)
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: authFlow,
            withNextStepper: OneStepper(withSingleStep: FlowSteps.selectAuthService))
        )
    }
    
}
