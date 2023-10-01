//
//  Coordinator.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.

protocol Coordinator {
    
    var childCoordinators: [Coordinator] { get set }
    
    func start()
    func stop()
}
