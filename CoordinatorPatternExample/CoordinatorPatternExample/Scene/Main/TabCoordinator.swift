//
//  TabCoordinator.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

final class TabCoordinator: Coordinator {
    
    // MARK: Property(s)
    
    var childCoordinators: [UUID : Coordinator] = [:]
    let identifier: UUID = UUID()
    
    // MARK: Function(s)
    
    func start() {
        
    }
}
