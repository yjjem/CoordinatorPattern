//
//  DetailCoordinator.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2024 Jeremy All rights reserved.
    

import Foundation

final class DetailCoordinator: Coordinator {
    
    private let rootView: DetailViewController
    
    init(rootView: DetailViewController) {
        self.rootView = rootView
    }
}
