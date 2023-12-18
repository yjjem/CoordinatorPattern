//
//  Coordinator.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

class Coordinator: FlowResponder, CoordinatorProtocol {
    
    var childCoordinators: [UUID : CoordinatorProtocol] = [:]
    let identifier: UUID = .init()
    
    func start() { }
}

