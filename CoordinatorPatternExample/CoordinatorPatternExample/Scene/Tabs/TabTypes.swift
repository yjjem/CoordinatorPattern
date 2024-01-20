//
//  TabType.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

enum TabTypes: String {
    case list
    case profile
    case browse
    
    var tabBarItem: UITabBarItem {
        return UITabBarItem(
            title: rawValue.capitalized,
            image: defaultIcon,
            selectedImage: selectedIcon
        )
    }
    
    private var defaultIconName: String {
        switch self {
        case .list: return "list.bullet.circle"
        case .profile: return "person.crop.circle"
        case .browse: return "sparkles"
        }
    }
    
    private var selectedIconName: String {
        return defaultIconName + ".fill"
    }
    
    private var defaultIcon: UIImage? {
        return UIImage(systemName: defaultIconName)
    }
    
    private var selectedIcon: UIImage? {
        return UIImage(systemName: selectedIconName)
    }
}
