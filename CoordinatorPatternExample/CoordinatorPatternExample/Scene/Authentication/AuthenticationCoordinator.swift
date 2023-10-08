//
//  AuthenticationCoordinator.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

protocol AuthenticationCoordinatorFinishDelegate {
    
    func finishAuthenticationCoordinator()
}

final class AuthenticationCoordinator: Coordinator {
    
    // MARK: Property(s)
    
    var childCoordinators: [Coordinator] = []
    var delegate: AuthenticationCoordinatorFinishDelegate?
    
    let navigationController: UINavigationController
    
    // MARK: Initializer(s)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: Function(s)
    
    func start() {
        let authenticationViewController = AuthenticationSelectionProviderViewController()
        authenticationViewController.delegate = self
        authenticationViewController.configureName(with: "Authentication")
        navigationController.viewControllers = [authenticationViewController]
    }
}

extension AuthenticationCoordinator: AuthenticationDelegate {
    
    func startAuthentication(_ authenticationType: AuthenticationType) {
        startSelectedAuthentication(authenticationType)
    }
    
    func startSelectedAuthentication(_ authenticationType: AuthenticationType) {
        let authenticationDetail = AuthenticationHostViewController()
        authenticationDetail.delegate = self
        authenticationDetail.configureWith(authenticationType)
        navigationController.pushViewController(authenticationDetail, animated: true)
    }
}

extension AuthenticationCoordinator: AuthenticationFinishDelegate {
    
    func didFinishAuthentication(_ authenticationType: AuthenticationType) {
        delegate?.finishAuthenticationCoordinator()
    }
}
