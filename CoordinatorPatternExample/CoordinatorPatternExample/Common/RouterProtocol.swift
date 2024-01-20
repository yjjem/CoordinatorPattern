//
//  RouterProtocol.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2024 Jeremy All rights reserved.
    

import UIKit

protocol RouterProtocol: NSObject, UINavigationControllerDelegate {
    func push(_ viewController: UIViewController, animated: Bool)
    func push(_ viewController: UIViewController, animated: Bool, _ completion: (() -> Void)?)
    func present(_ viewController: UIViewController, animated: Bool)
    func present(_ viewController: UIViewController, animated: Bool, _ completion: (() -> Void)?)
    func pop(animated: Bool)
    func dismiss(animated: Bool)
}
