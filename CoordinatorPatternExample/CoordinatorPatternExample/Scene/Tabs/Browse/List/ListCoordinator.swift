//
//  ListCoordinator.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2024 Jeremy All rights reserved.
    

import Foundation

final class ListCoordinator: Coordinator {
    
    private let rootView: ListViewController
    
    init(rootView: ListViewController) {
        self.rootView = rootView
    }
}
