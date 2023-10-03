//
//  AuthenticationDetailViewController.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

final class AuthenticationDetailViewController: NamedViewController {
    
    // MARK: Override(s)
    
    override func loadView() {
        super.loadView()
    }
    
    // MARK: Function(s)
    
    func configureWith(_ authenticationType: AuthenticationType) {
        view.backgroundColor = authenticationType.representiveColor
        configureName(with: authenticationType.name)
    }
}
