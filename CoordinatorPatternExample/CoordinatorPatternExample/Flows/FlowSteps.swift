//
//  FlowSteps.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2024 Jeremy All rights reserved.
    

import RxFlow

enum FlowSteps: Step {
    
    // MARK: Auth
    case auth
    case selectAuthService
    case enterAuth(type: AuthServiceType)
    case finishAuth
    
    // MARK: TabBar
    case tabBar
    case tabMainProfile
    case tapNumbersFilter
    case numberSelected(number: Int)
}
