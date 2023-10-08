//
//  AthenticationType.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

enum AuthenticationType: String {
    case naver
    case kakao
    case google
    
    var name: String {
        return rawValue.uppercased()
    }
    
    var color: UIColor {
        switch self {
        case .naver: return .systemGreen
        case .kakao: return .systemYellow
        case .google: return .systemGray
        }
    }
}
