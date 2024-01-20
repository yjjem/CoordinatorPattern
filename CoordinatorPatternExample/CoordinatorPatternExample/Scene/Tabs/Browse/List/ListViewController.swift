//
//  ListViewController.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2024 Jeremy All rights reserved.
    

import UIKit

protocol ListViewControllerDelegate: AnyObject {
    func didTapListView()
}

final class ListViewController: SingleLargeTitleViewController {
    
    // MARK: Property(s)
    
    weak var delegate: ListViewControllerDelegate?
    
    // MARK: Override(s)
    
    override func loadView() {
        super.loadView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: Runtime Function(s)
    
    @objc private func didTap() {
        delegate?.didTapListView()
    }
}
