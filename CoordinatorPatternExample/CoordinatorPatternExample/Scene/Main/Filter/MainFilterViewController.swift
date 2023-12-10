//
//  MainFilterViewController.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

protocol MainFilterViewControllerDelegate {
    func didSelectRange(minNumber: Int, maxNumber: Int)
}

final class MainFilterViewController: UIViewController {
    
    // MARK: Property(s)
    
    var delegate: MainFilterViewControllerDelegate?
    
    private var minimumValue: Int = 1
    private var maximumValue: Int = 1
    
    private let titleLabel: UILabel = UILabel()
    private let minSelector: NumberSelectorView = NumberSelectorView(name: "min")
    private let maxSelector: NumberSelectorView = NumberSelectorView(name: "max")
    private let selectorStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.spacing = 10
        return stack
    }()
    
    private let confirmButton: UIButton = UIButton()
    
    // MARK: Override(s)
    
    override func loadView() {
        super.loadView()
        
        configureHierarchy()
        configureConfirmButton()
        selectedValues()
    }
    
    // MARK: Private Function(s)
    
    @objc private func didSelectRange() {
        if minimumValue > maximumValue, maximumValue < minimumValue {
            if minimumValue > maximumValue {
                minSelector.markAsInvalidSelection()
            } else if maximumValue < minimumValue {
                maxSelector.markAsInvalidSelection()
            }
            showInvalidSelectionAlert()
        } else {
            delegate?.didSelectRange(minNumber: minimumValue, maxNumber: maximumValue)
        }
    }
    
    private func showInvalidSelectionAlert() {
        let action = UIAlertAction(title: "Ok", style: .cancel)
        let alert = UIAlertController(
            title: "Invalid Range",
            message: "Please select valid filter range.",
            preferredStyle: .alert
        )
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    private func selectedValues() {
        minSelector.selectedNumber = { [weak self] min in
            self?.minimumValue = min
        }
        
        maxSelector.selectedNumber = { [weak self] max in
            self?.maximumValue = max
        }
    }
    
    private func configureConfirmButton() {
        view.addSubview(confirmButton)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.backgroundColor = .systemBlue
        NSLayoutConstraint.activate([
            confirmButton.topAnchor.constraint(equalTo: selectorStack.bottomAnchor, constant: 20),
            confirmButton.widthAnchor.constraint(equalToConstant: 100),
            confirmButton.heightAnchor.constraint(equalToConstant: 50),
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.addTarget(
            self,
            action: #selector(didSelectRange),
            for: .touchUpInside
        )
        confirmButton.layer.cornerRadius = 25
        titleLabel.text = "Filter range"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    }
    
    private func configureHierarchy() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            titleLabel.heightAnchor.constraint(equalToConstant: 32),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(selectorStack)
        selectorStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectorStack.widthAnchor.constraint(equalToConstant: 200),
            selectorStack.heightAnchor.constraint(equalToConstant: 200),
            selectorStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectorStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        ])
        
        selectorStack.addArrangedSubview(minSelector)
        NSLayoutConstraint.activate([
            minSelector.widthAnchor.constraint(equalToConstant: 80),
            minSelector.heightAnchor.constraint(equalToConstant: 100)
        ])
        selectorStack.addArrangedSubview(maxSelector)
        NSLayoutConstraint.activate([
            maxSelector.widthAnchor.constraint(equalToConstant: 80),
            maxSelector.heightAnchor.constraint(equalToConstant: 100)
        ])

    }
}

#Preview {
    MainFilterViewController()
}
