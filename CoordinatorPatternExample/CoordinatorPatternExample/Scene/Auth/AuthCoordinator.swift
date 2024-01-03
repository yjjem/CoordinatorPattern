//
//  AuthenticationCoordinator.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

protocol AuthCoordinatorFinishDelegate: AnyObject {
    
    func finishAuthenticationCoordinator(_ identifier: UUID)
}

final class AuthCoordinator: Coordinator {
    
    // MARK: Property(s)
    
    weak var delegate: AuthCoordinatorFinishDelegate?
    var childCoordinators: [UUID: Coordinator] = [:]
    
    let identifier: UUID = UUID()
    let navigationController: UINavigationController
    
    private let authenticator: AuthPerformer = .init()
    
    // MARK: Initializer(s)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: Function(s)
    
    func start() {
        let authenticationViewController = AuthServiceSelectorViewController()
        authenticationViewController.delegate = self
        authenticationViewController.configureName(with: "Authentication")
        navigationController.pushViewController(authenticationViewController, animated: true)
    }
}

// MARK: AuthenticationDelegate

extension AuthCoordinator: AuthServiceSelectorViewControllerDelegate {
    
    func startAuthentication(_ authenticationType: AuthServiceType) {
        startSelectedAuthentication(authenticationType)
    }
    
    func startSelectedAuthentication(_ authenticationType: AuthServiceType) {
        let authenticationDetail = AuthUserEntryViewController()
        authenticationDetail.delegate = self
        authenticationDetail.configureWith(authenticationType)
        navigationController.pushViewController(authenticationDetail, animated: true)
    }
}

// MARK: AuthenticationFinishDelegate

extension AuthCoordinator: AuthUserEntryViewControllerDelegate {
    
    func didFinishAuthentication(_ authenticationType: AuthServiceType) {
        authenticator.logIn()
        delegate?.finishAuthenticationCoordinator(identifier)
    }
}
