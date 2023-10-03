//
//  AuthenticationDetailViewController.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

protocol AuthenticationFinishDelegate {
    
    func didFinishAuthentication(_ authenticationType: AuthenticationType)
}

final class AuthenticationDetailViewController: NamedViewController {
    
    // MARK: Property(s)
    
    private let finishButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("Finish", for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    var authenticationType: AuthenticationType?
    var delegate: AuthenticationFinishDelegate?
    
    // MARK: Override(s)
    
    override func loadView() {
        super.loadView()
        
        configureButtonAction()
        configureHierarchy()
    }
    
    // MARK: Function(s)
    
    func configureWith(_ authenticationType: AuthenticationType) {
        self.authenticationType = authenticationType
        view.backgroundColor = authenticationType.representiveColor
        configureName(with: authenticationType.name)
    }
    
    // MARK: Runtime Function(s)
    
    @objc func didTapFinishButton() {
        
        guard let authenticationType else { return }
        
        delegate?.didFinishAuthentication(authenticationType)
    }
    
    // MARK: Private Function(s)
    
    private func configureButtonAction() {
        finishButton.addTarget(
            self, action: #selector(didTapFinishButton),
            for: .touchUpInside
        )
    }
    
    private func configureHierarchy() {
        view.addSubview(finishButton)
        
        finishButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            finishButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 50),
            finishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            finishButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
