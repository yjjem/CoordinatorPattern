//
//  AuthenticationViewController.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit
import RxFlow
import RxCocoa
import RxRelay
import RxSwift

final class AuthServiceSelectorViewController: SingleLargeTitleViewController, Stepper {
    
    // MARK: Property(s)
    
    let steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
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
    
    // MARK: Private Function(s)
    
    private func configureButtonActions() {
        greenAuthenticationButton.rx.tap
            .take(until: rx.deallocating)
            .map { FlowSteps.enterAuth(type: .naver) }
            .bind(to: steps)
            .disposed(by: disposeBag)
        
        yellowAuthenticationButton.rx.tap
            .take(until: rx.deallocating)
            .map { FlowSteps.enterAuth(type: .kakao) }
            .bind(to: steps)
            .disposed(by: disposeBag)
        
        grayAuthenticationButton.rx.tap
            .take(until: rx.deallocating)
            .map { FlowSteps.enterAuth(type: .google) }
            .bind(to: steps)
            .disposed(by: disposeBag)
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
            authenticationButtonsStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            authenticationButtonsStack.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
}
