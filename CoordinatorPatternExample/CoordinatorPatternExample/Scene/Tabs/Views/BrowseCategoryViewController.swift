//
//  BrowseCategoryViewController.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2024 Jeremy All rights reserved.
    

import UIKit

protocol BrowseCategoryViewControllerDelegate: AnyObject {
    func didTapCategoryView()
}

final class BrowseCategoryViewController: SingleLargeTitleViewController {
    
    // MARK: Property(s)
    
    weak var delegate: BrowseCategoryViewControllerDelegate?
    
    // MARK: Override(s)
    
    override func loadView() {
        super.loadView()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: Runtime Function(s)
    
    @objc private func didTap() {
        delegate?.didTapCategoryView()
    }
}

