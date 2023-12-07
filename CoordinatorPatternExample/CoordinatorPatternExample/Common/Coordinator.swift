//
//  Coordinator.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.

import UIKit

protocol Coordinator {
    
    var childCoordinators: [UUID: Coordinator] { get set }
    var identifier: UUID  { get }
    
    func start()
}
