//
//  LabeledViewController.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

class NamedViewController: UIViewController {
    
    // MARK: Property(s)
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 34, weight: .heavy)
        return label
    }()
    
    var nameLabelBottomAnchor: NSLayoutYAxisAnchor {
        return nameLabel.bottomAnchor
    }
    
    // MARK: Override(s)
    
    override func loadView() {
        super.loadView()
        
        addViewHierarchy()
    }
    
    // MARK: Function(s)
    
    func configureName(with name: String) {
        nameLabel.text = name
    }
    
    // MARK: Private Function(s)
    
    private func addViewHierarchy() {
        view.backgroundColor = .systemBackground
        view.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
}
