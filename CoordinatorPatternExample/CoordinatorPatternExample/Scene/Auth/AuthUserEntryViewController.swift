//
//  AuthenticationDetailViewController.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit
import RxRelay
import RxFlow
import RxCocoa
import RxSwift

final class AuthUserEntryViewController: SingleLargeTitleViewController, Stepper {
    
    // MARK: Property(s)
    
    let steps: PublishRelay<Step> = .init()
    
    private var authenticationType: AuthServiceType?
    
    private let disposeBag: DisposeBag = .init()
    
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
    
    // MARK: Function(s)
    
    func configureWith(_ authenticationType: AuthServiceType) {
        self.authenticationType = authenticationType
        view.backgroundColor = authenticationType.color
        configureName(with: authenticationType.name)
    }
    
    // MARK: Private Function(s)
    
    private func configureButtonAction() {
        finishButton.rx.tap
            .take(until: rx.deallocated)
            .map { FlowSteps.finishAuth }
            .bind(to: steps)
            .disposed(by: disposeBag)
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
