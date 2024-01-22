//
//  MainContentViewController.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit
import RxFlow
import RxRelay
import RxSwift
import RxCocoa

final class MainContentListViewController: SingleLargeTitleViewController, Stepper {
    
    // MARK: Property(s)
    
    let steps: PublishRelay<Step> = .init()
    
    private let contentStorage: MainContentStorage = .init()
    private let disposeBag: DisposeBag = .init()
    
    private let imageContentCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero, collectionViewLayout: .init()
        )
        return collectionView
    }()
    
    // MARK: Override(s)
    
    override func loadView() {
        super.loadView()
        
        configureHierarchy()
        configureNavigationItem()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        contentStorage.fetchMainContentList()
    }
    
    // MARK: Function(s)
    
    func selectItemsRange(minValue: Int, maxValue: Int) {
        contentStorage.filterContentList(minValue: minValue, maxValue: maxValue)
        imageContentCollectionView.reloadData()
    }
    
    // MARK: Private Function(s)
    
    private func configureNavigationItem() {
        let profileIcon = UIImage(systemName: "person.crop.circle.fill")
        let filterIcon = UIImage(systemName: "slider.horizontal.3")
        
        let showProfileButton = UIBarButtonItem(
            image: profileIcon,
            style: .plain,
            target: self,
            action: nil
        )
        let filterBarButtonItem = UIBarButtonItem(
            image: filterIcon,
            style: .plain,
            target: self,
            action: nil
        )
        
        showProfileButton.rx.tap
            .take(until: rx.deallocated)
            .map { FlowSteps.tapMainProfile }
            .bind(to: steps)
            .disposed(by: disposeBag)
        
        filterBarButtonItem.rx.tap
            .take(until: rx.deallocated)
            .map { FlowSteps.tapNumbersFilter }
            .bind(to: steps)
            .disposed(by: disposeBag)
        
        let barButtonItems: [UIBarButtonItem] = [showProfileButton, filterBarButtonItem]
        navigationItem.rightBarButtonItems = barButtonItems
        navigationItem.title = "Main"
    }
    
    private func configureCollectionView() {
        let collectionViewLayout = makeCollectionViewLayout()
        imageContentCollectionView.dataSource = self
        imageContentCollectionView.setCollectionViewLayout(collectionViewLayout, animated: true)
        imageContentCollectionView.register(
            MainContentCell.self,
            forCellWithReuseIdentifier: "cell"
        )
        imageContentCollectionView.rx.itemSelected
            .map { self.contentStorage.contentList[$0.item] }
            .map { FlowSteps.numberSelected(number: $0.number) }
            .bind(to: steps)
            .disposed(by: disposeBag)
    }
    
    private func configureHierarchy() {
        let topSafeAnchor = view.safeAreaLayoutGuide.topAnchor
        view.addSubview(imageContentCollectionView)
        imageContentCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageContentCollectionView.topAnchor.constraint(equalTo: topSafeAnchor),
            imageContentCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageContentCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageContentCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func makeCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalWidth(0.5)
        )
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.5)
        )
        
        let leadingItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let trailingItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [leadingItem, trailingItem]
        )
        group.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

// MARK: UICollectionViewDataSource

extension MainContentListViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let cell = imageContentCollectionView.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath
        ) as! MainContentCell
        let content = contentStorage.contentList[indexPath.item]
        cell.configure(with: content.number)
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return contentStorage.contentList.count
    }
}
