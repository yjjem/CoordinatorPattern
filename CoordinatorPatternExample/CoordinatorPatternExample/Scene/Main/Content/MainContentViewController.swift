//
//  MainContentViewController.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

protocol MainContentItemSelectionDelegate {
    func didSelectItem(at index: Int)
}

protocol MainContentButtonSelectionDelegate {
    func didTapFilterButton()
    func didTapProfileButton()
}

final class MainContentViewController: NamedViewController {
    
    // MARK: Property(s)
    
    var itemSelectionDelegate: MainContentItemSelectionDelegate?
    var buttonSelectionDelegate: MainContentButtonSelectionDelegate?
    
    private let contentStorage: MainContentStorage = .init()
    
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
    
    // MARK: Private Function(s)
    
    private func configureNavigationItem() {
        let profileIcon = UIImage(systemName: "person.crop.circle.fill")
        let filterIcon = UIImage(systemName: "slider.horizontal.3")
        
        let showProfileButton = UIBarButtonItem(
            image: profileIcon,
            style: .plain,
            target: self,
            action: #selector(didTapShowProfileButton)
        )
        let filterBarButtonItem = UIBarButtonItem(
            image: filterIcon,
            style: .plain,
            target: self,
            action: #selector(didTapFilterButton)
        )
        
        let barButtonItems: [UIBarButtonItem] = [showProfileButton, filterBarButtonItem]
        navigationItem.rightBarButtonItems = barButtonItems
        navigationItem.title = "Main"
    }
    
    @objc private func didTapFilterButton() {
        buttonSelectionDelegate?.didTapFilterButton()
    }
    
    @objc private func didTapShowProfileButton() {
        buttonSelectionDelegate?.didTapProfileButton()
    }
    
    private func configureCollectionView() {
        let collectionViewLayout = makeCollectionViewLayout()
        imageContentCollectionView.dataSource = self
        imageContentCollectionView.delegate = self
        imageContentCollectionView.setCollectionViewLayout(collectionViewLayout, animated: true)
        imageContentCollectionView.register(
            MainContentCell.self,
            forCellWithReuseIdentifier: "cell"
        )
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

extension MainContentViewController: UICollectionViewDataSource {
    
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

// MARK: UICollectionViewDelegate

extension MainContentViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        itemSelectionDelegate?.didSelectItem(at: indexPath.item)
    }
}
