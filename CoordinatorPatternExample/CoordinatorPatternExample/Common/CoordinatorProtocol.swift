//
//  CoordinatorProtocol.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

protocol CoordinatorProtocol: FlowResponder, AnyObject {
    
    var childCoordinators: [UUID: CoordinatorProtocol] { get set }
    var identifier: UUID  { get }
    
    func start()
}

extension CoordinatorProtocol {
    
    func addChild(coordinator: CoordinatorProtocol) {
        childCoordinators[coordinator.identifier] = coordinator
        coordinator.setNext(flowResponder: self)
    }
    
    func removeChild(coordinator: CoordinatorProtocol) {
        coordinator.removeAllChildCoordinators()
        childCoordinators.removeValue(forKey: coordinator.identifier)
    }
    
    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
}
