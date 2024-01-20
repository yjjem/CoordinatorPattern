//
//  Router.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2024 Jeremy All rights reserved.
    

import UIKit

final class Router: NSObject, UINavigationControllerDelegate, RouterProtocol {
    
    // MARK: Property(s)
    
    private var completions: [UIViewController: () -> Void] = [:]
    private let navigationController: UINavigationController
    
    // MARK: Initializer(s)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        navigationController.delegate = self
    }
    
    // MARK: Function(s)
    
    func push(_ viewController: UIViewController, animated: Bool) {
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func push(
        _ viewController: UIViewController,
        animated: Bool,
        _ completion: (() -> Void)? = nil
    ) {
        navigationController.pushViewController(viewController, animated: animated)
        if let completion {
            completions[viewController] = completion
        }
    }
    
    func present(_ viewController: UIViewController, animated: Bool) {
        navigationController.present(viewController, animated: animated)
    }
    
    func present(
        _ viewController: UIViewController,
        animated: Bool,
        _ completion: (() -> Void)? = nil
    ) {
        navigationController.present(viewController, animated: animated)
        if let completion {
            completions[viewController] = completion
        }
    }
    
    func pop(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }
    
    func dismiss(animated: Bool) {
        navigationController.dismiss(animated: animated)
    }
    
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        
        if case .pop = operation, let compl = completions[fromVC] {
            compl()
            completions.removeValue(forKey: fromVC)
        }
        
        return nil
    }
}
