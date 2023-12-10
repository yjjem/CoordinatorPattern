//
//  NumberSelectorView.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

final class NumberSelectorView: UIView {
    
    // MARK: Property(s)
    
    var selectedNumber: ((Int) -> Void)?
    
    private var numbers: [Int] = Array(1...80)
    
    private let pickerName: UILabel = UILabel()
    private let numberPicker: UIPickerView = UIPickerView()
    private let stackView: UIStackView = UIStackView()
    
    // MARK: Initializer(s)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(name: String) {
        self.init(frame: .zero)
        setTitle(name)
        configureHierarchy()
        additionalSettings()
    }
    
    // MARK: Function(s)
    
    func markAsInvalidSelection() {
        numberPicker.layer.borderColor = UIColor.systemRed.cgColor
    }
    
    private func removeInvalidSelectionMark() {
        numberPicker.layer.borderColor = UIColor.black.cgColor
    }
    
    // MARK: Private Function(s)
    
    private func setTitle(_ title: String) {
        pickerName.text = title
    }
    
    private func configureHierarchy() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        stackView.addArrangedSubview(pickerName)
        stackView.addArrangedSubview(numberPicker)
        NSLayoutConstraint.activate([
            numberPicker.widthAnchor.constraint(equalToConstant: 80),
            numberPicker.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    private func additionalSettings() {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        
        pickerName.font = UIFont.systemFont(ofSize: 16, weight: .light)
        
        numberPicker.backgroundColor = .secondarySystemBackground
        numberPicker.layer.cornerRadius = 12
        numberPicker.layer.borderWidth = 3
        numberPicker.dataSource = self
        numberPicker.delegate = self
    }
}

extension NumberSelectorView: UIPickerViewDelegate {
    
    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        return String(numbers[row])
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int
    ) {
        removeInvalidSelectionMark()
        selectedNumber?(numbers[row])
    }
}

extension NumberSelectorView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numbers.count
    }
}

#Preview {
    NumberSelectorView(name: "min")
}
