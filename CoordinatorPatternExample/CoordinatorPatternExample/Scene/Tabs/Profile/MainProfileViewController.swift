//
//  MainProfileViewController.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

protocol MainProfileViewControllerDelegate {
    
    func didTapLogOutButton()
}

final class MainProfileViewController: UIViewController {
    
    var delegate: MainProfileViewControllerDelegate?
    
    // MARK: Property(s)
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .secondarySystemFill
        imageView.image = UIImage(named: "default-man")
        imageView.layer.cornerRadius = 75
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        label.textAlignment = .center
        label.text = "User"
        return label
    }()
    
    private let accentColorView: UIView = UIView()
    private let logOutButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: nil)
        return button
    }()
    
    // MARK: Override(s)
    
    override func loadView() {
        super.loadView()
        
        configureViewStyle()
        configureViewHierarchy()
    }
    
    // MARK: Private Function(s)
    
    private func configureViewStyle() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureViewHierarchy() {
        accentColorView.backgroundColor = .systemGray4
        view.addSubview(accentColorView)
        accentColorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            accentColorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            accentColorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            accentColorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            accentColorView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
        
        
        view.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 150),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.centerYAnchor.constraint(
                equalTo: accentColorView.bottomAnchor,
                constant: -20
            )
        ])
        
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.widthAnchor.constraint(equalToConstant: 100),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
            nameLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20)
        ])
        
        view.addSubview(logOutButton)
        configureLogOutButtonStyle()
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logOutButton.widthAnchor.constraint(equalToConstant: 150),
            logOutButton.heightAnchor.constraint(equalToConstant: 50),
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logOutButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])
    }
    
    private func configureLogOutButtonStyle() {
        logOutButton.layer.cornerRadius = 15
        logOutButton.layer.masksToBounds = true
        logOutButton.backgroundColor = .systemRed
        logOutButton.setTitle("Log Out", for: .normal)
        logOutButton.setTitleColor(.white, for: .normal)
        logOutButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        logOutButton.addTarget(self, action: #selector(didTapLogOutButton), for: .touchUpInside)
    }
    
    @objc private func didTapLogOutButton() {
        delegate?.didTapLogOutButton()
    }
}
