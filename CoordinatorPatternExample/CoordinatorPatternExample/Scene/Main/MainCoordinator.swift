//
//  MainCoordinator.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit
import Foundation

protocol MainCoordinatorFinishDelegate {
    func finishMainCoordinator(_ identifier: UUID)
}

final class MainCoordinator: Coordinator {
    
    // MARK: Property(s)
    
    var delegate: MainCoordinatorFinishDelegate?
    var childCoordinators: [UUID: Coordinator] = [:]
    
    let identifier: UUID = UUID()
    
    private let navigationController: UINavigationController
    private let authenticator: Authenticator = Authenticator()
    
    // MARK: Initializer(s)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: Function(s)
    
    func start() {
        showMainFlow()
    }
    
    // MARK: Private Function(s)
    
    private func showMainFlow() {
        let mainContentViewController = MainContentViewController()
        mainContentViewController.delegate = self
        navigationController.pushViewController(mainContentViewController, animated: true)
    }
    
    private func showDetailFlow(_ itemNumber: Int) {
        let selectedItemName: String = String(itemNumber)
        let detailViewController = MainContentDetailViewController()
        detailViewController.configureName(with: selectedItemName)
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    private func showProfileFlow() {
        let profileViewController = MainProfileViewController()
        profileViewController.delegate = self
        navigationController.pushViewController(profileViewController, animated: true)
    }
    
    private func showFilterFlow() {
        let filterViewController = MainFilterViewController()
        filterViewController.modalPresentationStyle = .popover
        filterViewController.delegate = self
        navigationController.present(filterViewController, animated: true)
    }
}

// MARK: MainProfileViewControllerDelegate

extension MainCoordinator: MainProfileViewControllerDelegate {
    
    func didTapLogOutButton() {
        authenticator.logOut()
        delegate?.finishMainCoordinator(identifier)
    }
}

extension MainCoordinator: MainFilterViewControllerDelegate {
    
    func didSelectRange(minNumber: Int, maxNumber: Int) {
        // TODO: connect to main view
    }
}

// MARK: MainContentSelectionDelegate

extension MainCoordinator: MainContentSelectionDelegate {
    
    func didSelectItem(with index: Int) {
        showDetailFlow(index)
    }
    
    func didTapFilterButton() {
        showFilterFlow()
    }
    
    func didTapProfileButton() {
        showProfileFlow()
    }
}
