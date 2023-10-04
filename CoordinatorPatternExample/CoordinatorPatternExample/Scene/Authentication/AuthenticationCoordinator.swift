//
//  AuthenticationCoordinator.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

enum AuthenticationType: String {
    case naver
    case kakao
    case google
    
    var name: String {
        return rawValue.uppercased()
    }
    
    var color: UIColor {
        switch self {
        case .naver: return .systemGreen
        case .kakao: return .systemYellow
        case .google: return .systemGray
        }
    }
}

protocol AuthenticationCoordinatorFinishDelegate {
    
    func finish()
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
        let authenticationViewController = AuthenticationViewController()
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
        let authenticationDetail = AuthenticationDetailViewController()
        authenticationDetail.delegate = self
        authenticationDetail.configureWith(authenticationType)
        navigationController.pushViewController(authenticationDetail, animated: true)
    }
}

extension AuthenticationCoordinator: AuthenticationFinishDelegate {
    
    func didFinishAuthentication(_ authenticationType: AuthenticationType) {
        delegate?.finish()
    }
}
