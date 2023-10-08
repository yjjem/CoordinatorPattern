//
//  MainContentViewController.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

protocol MainContentSelectionDelegate {
    func didSelectItem(with index: Int)
}

final class MainContentViewController: NamedViewController {
    
    // MARK: Property(s)
    
    var delegate: MainContentSelectionDelegate?
    
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
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        
        imageContentCollectionView.dataSource = self
        imageContentCollectionView.delegate = self
        
        imageContentCollectionView.setCollectionViewLayout(
            makeCollectionViewLayout(),
            animated: true
        )
        
        imageContentCollectionView.register(
            MainContentCell.self,
            forCellWithReuseIdentifier: "cell"
        )
    }
    
    private func configureHierarchy() {
        view.addSubview(imageContentCollectionView)
        
        imageContentCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageContentCollectionView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            imageContentCollectionView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
            imageContentCollectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            imageContentCollectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            )
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
        
        cell.configure(with: indexPath.item)
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 50
    }
}

// MARK: UICollectionViewDelegate

extension MainContentViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem(with: indexPath.item)
    }
}
