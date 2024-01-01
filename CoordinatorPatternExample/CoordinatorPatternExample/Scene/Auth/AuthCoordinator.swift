//
//  AuthenticationCoordinator.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

protocol AuthCoordinatorFinishDelegate: AnyObject {
    
    func finishAuthenticationCoordinator(_ sender: CoordinatorProtocol)
}

final class AuthCoordinator: Coordinator {
    
    // MARK: Property(s)
    
    weak var delegate: AuthCoordinatorFinishDelegate?
    
    private let window: UIWindow
    private let navigationController: UINavigationController = UINavigationController()
    private let authenticator: AuthPerformer = .init()
    
    // MARK: Initializer(s)
    
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: Function(s)
    
    override func start() {
        window.rootViewController = navigationController
        showAuthServiceSelectorFlow()
    }
    
    // MARK: Private Function(s)
    
    private func showAuthServiceSelectorFlow() {
        let authenticationViewController = AuthServiceSelectorViewController()
        authenticationViewController.configureName(with: "Authentication")
        authenticationViewController.delegate = self
        navigationController.setViewControllers([authenticationViewController], animated: true)
    }
    
    private func showAuthEntryFlow(authService: AuthServiceType) {
        let authenticationDetail = AuthUserEntryViewController()
        authenticationDetail.configureWith(authService)
        authenticationDetail.delegate = self
        navigationController.pushViewController(authenticationDetail, animated: true)
    }
}

// MARK: AuthenticationDelegate

extension AuthCoordinator: AuthServiceSelectorViewControllerDelegate {
    
    func startAuthentication(_ authService: AuthServiceType) {
        showAuthEntryFlow(authService: authService)
    }
}

// MARK: AuthenticationFinishDelegate

extension AuthCoordinator: AuthUserEntryViewControllerDelegate {
    
    func didFinishAuthentication(_ authenticationType: AuthServiceType) {
        authenticator.logIn()
        delegate?.finishAuthenticationCoordinator(self)
    }
}
