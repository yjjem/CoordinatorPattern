//
//  Coordinator.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

protocol Coordinator: AnyObject {
    
    var childCoordinators: [UUID: Coordinator] { get set }
    var identifier: UUID  { get }
    
    func start()
}

extension Coordinator {
    
    func addChild(coordinator: Coordinator) {
        childCoordinators[coordinator.identifier] = coordinator
    }
    
    func removeChild(coordinator: Coordinator) {
        coordinator.removeAllChildCoordinators()
        childCoordinators.removeValue(forKey: coordinator.identifier)
    }
    
    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
}
