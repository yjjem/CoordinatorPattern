//
//  AuthenticationDetailViewController.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

protocol AuthUserEntryViewControllerDelegate {
    
    func didFinishAuthentication(_ authenticationType: AuthServiceType)
}

final class AuthUserEntryViewController: SingleLargeTitleViewController {
    
    // MARK: Property(s)
    
    var delegate: AuthUserEntryViewControllerDelegate?
    
    private var authenticationType: AuthServiceType?
    
    private let finishButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("Sign in", for: .normal)
        button.setTitle("Processing...", for: .disabled)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    // MARK: Override(s)
    
    override func loadView() {
        super.loadView()
        configureButtonAction()
        configureHierarchy()
    }
    
    // MARK: Runtime Function(s)
    
    @objc func didTapFinishButton() {
        guard let authenticationType else { return }
        finishButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
            self.delegate?.didFinishAuthentication(authenticationType)
        }
    }
    
    // MARK: Function(s)
    
    func configureWith(_ authenticationType: AuthServiceType) {
        self.authenticationType = authenticationType
        view.backgroundColor = authenticationType.color
        configureName(with: authenticationType.name)
    }
    
    // MARK: Private Function(s)
    
    private func configureButtonAction() {
        finishButton.addTarget(self, action: #selector(didTapFinishButton), for: .touchUpInside)
    }
    
    private func configureHierarchy() {
        view.addSubview(finishButton)
        finishButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            finishButton.topAnchor.constraint(equalTo: nameLabelBottomAnchor, constant: 50),
            finishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            finishButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
