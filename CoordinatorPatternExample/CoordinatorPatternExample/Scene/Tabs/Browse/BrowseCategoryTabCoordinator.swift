//
//  BrowseCategoryTabCoordinator.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2024 Jeremy All rights reserved.
    

import UIKit

final class BrowseCategoryTabCoordinator: Coordinator {
    
    // MARK: Property(s)
    
    private let navigationController: UINavigationController
    private lazy var router: RouterProtocol = {
        return Router(navigationController: navigationController)
    }()
    
    // MARK: Initializer(s)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: Function(s)
    
    override func start() {
        showBrowseCategoryFlow()
    }
    
    // MARK: Private Function(s)
    
    private func showBrowseCategoryFlow() {
        let browseCategoryViewController = BrowseCategoryViewController()
        browseCategoryViewController.configureName(with: "Browse Category")
        browseCategoryViewController.delegate = self
        router.push(browseCategoryViewController, animated: true)
    }
    
    private func showListFlow() {
        let listViewController = ListViewController()
        listViewController.configureName(with: "List")
        listViewController.delegate = self
        let listCoordinator = ListCoordinator(rootView: listViewController)
        listCoordinator.start()
        addChild(coordinator: listCoordinator)
        router.push(listViewController, animated: true) { [weak self] in
            self?.removeChild(coordinator: listCoordinator)
        }
    }
    
    private func showDetailFlow() {
        let detailViewController = DetailViewController()
        detailViewController.configureName(with: "Detail")
        let detailCoordinator = DetailCoordinator(rootView: detailViewController)
        detailCoordinator.start()
        addChild(coordinator: detailCoordinator)
        router.push(detailViewController, animated: true) { [weak self] in
            self?.removeChild(coordinator: detailCoordinator)
        }
    }
}

// MARK: BrowseCategoryViewControllerDelegate

extension BrowseCategoryTabCoordinator: BrowseCategoryViewControllerDelegate {
    func didTapCategoryView() {
        showListFlow()
    }
}

// MARK: ListViewControllerDelegate

extension BrowseCategoryTabCoordinator: ListViewControllerDelegate {
    func didTapListView() {
        showDetailFlow()
    }
}
