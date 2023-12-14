//
//  MainContentDetailView.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

final class MainContentDetailViewController: SingleLargeTitleViewController {
    
    // MARK: Override(s)
    
    override func loadView() {
        super.loadView()
    }
    
    // MARK: Function(s)
    
    func configureWithContentItem(content: MainContent) {
        configureName(with: String(content.number))
    }
}
