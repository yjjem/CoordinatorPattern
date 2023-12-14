//
//  AuthenticationViewController.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

protocol AuthServiceSelectorViewControllerDelegate {
    func startAuthentication(_ authService: AuthServiceType)
}

final class AuthServiceSelectorViewController: SingleLargeTitleViewController {
    
    // MARK: Property(s)
    
    var delegate: AuthServiceSelectorViewControllerDelegate?
    
    private let authenticationButtonsStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    private let greenAuthenticationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Naver", for: .normal)
        button.backgroundColor = .systemGreen
        return button
    }()
    
    private let yellowAuthenticationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Kakao", for: .normal)
        button.backgroundColor = .systemYellow
        return button
    }()
    
    private let grayAuthenticationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Google", for: .normal)
        button.backgroundColor = .systemGray
        return button
    }()
    
    // MARK: Override(s)
    
    override func loadView() {
        super.loadView()
        
        configureHierarchy()
        configureViewStyle()
        configureButtonActions()
    }
    
    // MARK: Runtime Function(s)
    
    @objc private func didTapGreenAuthenticationButton() {
        delegate?.startAuthentication(.naver)
    }
    
    @objc private func didTapYellowAuthenticationButton() {
        delegate?.startAuthentication(.kakao)
    }
    
    @objc private func didTapGrayAuthenticationButton() {
        delegate?.startAuthentication(.google)
    }
    
    // MARK: Private Function(s)
    
    private func configureButtonActions() {
        greenAuthenticationButton.addTarget(
            self, action: #selector(didTapGreenAuthenticationButton),
            for: .touchUpInside
        )
        
        yellowAuthenticationButton.addTarget(
            self, action: #selector(didTapYellowAuthenticationButton),
            for: .touchUpInside
        )
        
        grayAuthenticationButton.addTarget(
            self, action: #selector(didTapGrayAuthenticationButton),
            for: .touchUpInside
        )
    }
    
    private func configureViewStyle() {
        
        view.backgroundColor = .systemBackground
        
        let buttons: [UIButton] = [
            greenAuthenticationButton,
            yellowAuthenticationButton,
            grayAuthenticationButton
        ]
        
        buttons.forEach {
            $0.layer.cornerRadius = 5
            $0.layer.masksToBounds = true
            $0.layer.borderWidth = 0.3
            $0.layer.borderColor = UIColor.black.cgColor
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
            $0.tintColor = .white
        }
    }
    
    private func configureHierarchy() {
        
        authenticationButtonsStack.addArrangedSubview(greenAuthenticationButton)
        authenticationButtonsStack.addArrangedSubview(yellowAuthenticationButton)
        authenticationButtonsStack.addArrangedSubview(grayAuthenticationButton)
        authenticationButtonsStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(authenticationButtonsStack)
        
        NSLayoutConstraint.activate([
            authenticationButtonsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authenticationButtonsStack.widthAnchor.constraint(equalToConstant: 200),
            authenticationButtonsStack.topAnchor.constraint(
                equalTo: nameLabelBottomAnchor,
                constant: 50
            )
        ])
    }
}
