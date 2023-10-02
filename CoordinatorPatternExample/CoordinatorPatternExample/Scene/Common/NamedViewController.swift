//
//  LabeledViewController.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

class NamedViewController: UIViewController {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        return label
    }()
    
    override func loadView() {
        super.loadView()
        
        addViewHierarchy()
    }
    
    func configureName(with name: String) {
        nameLabel.text = name
    }
    
    private func addViewHierarchy() {
        view.backgroundColor = .white
        view.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
}
