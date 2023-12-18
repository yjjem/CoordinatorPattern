//
//  MainContentCoordinator.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

final class MainContentCoordinator: Coordinator {
    
    // MARK: Property(s)
    
    private let rootController: MainContentListViewController
    private let authenticator: AuthPerformer = AuthPerformer()
    
    // MARK: Initializer(s)
    
    init(rootController: MainContentListViewController) {
        self.rootController = rootController
    }
    
    // MARK: Function(s)
    
    override func start() {
        rootController.barButtonsDelegate = self
    }
    
    // MARK: Private Function(s)
    
    private func showProfileFlow() {
        let profileViewController = MainProfileViewController()
        profileViewController.delegate = self
        rootController.present(profileViewController, animated: true)
    }
    
    private func showFilterFlow() {
        let filterViewController = MainFilterViewController()
        filterViewController.delegate = self
        rootController.present(filterViewController, animated: true)
    }
}

// MARK: MainContentButtonSelectionDelegate

extension MainContentCoordinator: MainContentBarButtonSelectionDelegate {
    
    func didTapFilterButton() {
        showFilterFlow()
    }
    
    func didTapProfileButton() {
        showProfileFlow()
    }
}

// MARK: MainProfileViewControllerDelegate

extension MainContentCoordinator: MainProfileViewControllerDelegate {
    
    func didTapLogOutButton() {
        authenticator.logOut()
        rootController.dismiss(animated: true)
        sendFlowEvent(#selector(LogOutEvent.didLogOut))
    }
}

// MARK: MainFilterViewControllerDelegate

extension MainContentCoordinator: MainFilterViewControllerDelegate {
    
    func didSelectRange(minNumber: Int, maxNumber: Int) {
        rootController.dismiss(animated: true)
        rootController.selectItemsRange(minValue: minNumber, maxValue: maxNumber)
    }
}
