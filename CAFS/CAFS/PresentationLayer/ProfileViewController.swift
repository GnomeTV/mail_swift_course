//
//  ProfileViewController.swift
//  CAFS
//
//  Created by Павел Травкин on 02.11.2020.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Views
    
    private let titleLabel = UILabel()
    private let firstnameTextField = UITextField()
    private let firstnameIndicatorView = UIView()
    private let lastnameTextField = UITextField()
    private let lastnameIndicatorView = UIView()
    private let universityTextField = UITextField()
    private let universityIndicatorView = UIView()
    private let saveButton = HseStyleButton()
    
    // MARK: - Insets
    
    private let leftInset: CGFloat = 224.0
    private let rightInset: CGFloat = 24.0
    private let buttonHeight: CGFloat = 48.0
    private let textFieldHeight: CGFloat = 24.0
    private let indicatorHeight: CGFloat = 2.0
    private let topInsetTextFieldIndicator: CGFloat = 3.0
    private let fontSizeTextField: CGFloat = 20.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
    }
    
    // MARK: - Private methods
    private func setupViews() {
        setupRegistrationLabel()
        setupSelfDataField() 
        positionTextFieldIndicators()
        setupSaveButton()
    }
    
    private func setupRegistrationLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.text = "Профиль"
        titleLabel.textColor = UIColor.hseBlue
        titleLabel.font = UIFont.systemFont(ofSize: 32.0, weight: .bold)

        titleLabel.heightAnchor.constraint(equalToConstant: 36.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: rightInset).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftInset).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60.0).isActive = true
    }
    
    private func setupSelfDataField() {
    
        view.addSubview(firstnameTextField)
        view.addSubview(lastnameTextField)
        view.addSubview(universityTextField)
            
        firstnameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastnameTextField.translatesAutoresizingMaskIntoConstraints = false
        universityTextField.translatesAutoresizingMaskIntoConstraints = false
        
        firstnameTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
        firstnameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftInset).isActive = true
        firstnameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -rightInset).isActive = true
        firstnameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -300.0).isActive = true
        
        firstnameTextField.placeholder = "Имя"
        firstnameTextField.font = UIFont.systemFont(ofSize: fontSizeTextField, weight: .regular)
        firstnameTextField.textColor = .black
        firstnameTextField.borderStyle = .none
        
        lastnameTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
        lastnameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftInset).isActive = true
        lastnameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -rightInset).isActive = true
        lastnameTextField.centerYAnchor.constraint(equalTo: firstnameTextField.bottomAnchor, constant: 64.0).isActive = true
        
        lastnameTextField.placeholder = "Фамилия"
        lastnameTextField.font = UIFont.systemFont(ofSize: fontSizeTextField, weight: .regular)
        lastnameTextField.textColor = .black
        lastnameTextField.borderStyle = .none
        
        universityTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
        universityTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftInset).isActive = true
        universityTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -rightInset).isActive = true
        universityTextField.centerYAnchor.constraint(equalTo: lastnameTextField.bottomAnchor, constant: 64.0).isActive = true
        
        universityTextField.placeholder = "Университет"
        universityTextField.font = UIFont.systemFont(ofSize: fontSizeTextField, weight: .regular)
        universityTextField.textColor = .black
        universityTextField.borderStyle = .none
        
    }
    
    private func positionTextFieldIndicators() {
        firstnameIndicatorView.backgroundColor = UIColor.hseBlue
        lastnameIndicatorView.backgroundColor = UIColor.hseBlue
        universityIndicatorView.backgroundColor = UIColor.hseBlue
        
        view.addSubview(firstnameIndicatorView)
        view.addSubview(lastnameIndicatorView)
        view.addSubview(universityIndicatorView)
        
        firstnameIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        lastnameIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        universityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        firstnameIndicatorView.heightAnchor.constraint(equalToConstant: indicatorHeight).isActive = true
        firstnameIndicatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftInset).isActive = true
        firstnameIndicatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -rightInset).isActive = true
        firstnameIndicatorView.topAnchor.constraint(equalTo: firstnameTextField.bottomAnchor, constant: topInsetTextFieldIndicator).isActive = true
        
        lastnameIndicatorView.heightAnchor.constraint(equalToConstant: indicatorHeight).isActive = true
        lastnameIndicatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftInset).isActive = true
        lastnameIndicatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -rightInset).isActive = true
        lastnameIndicatorView.topAnchor.constraint(equalTo: lastnameTextField.bottomAnchor, constant: topInsetTextFieldIndicator).isActive = true

        universityIndicatorView.heightAnchor.constraint(equalToConstant: indicatorHeight).isActive = true
        universityIndicatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftInset).isActive = true
        universityIndicatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -rightInset).isActive = true
        universityIndicatorView.topAnchor.constraint(equalTo: universityTextField.bottomAnchor, constant: topInsetTextFieldIndicator).isActive = true
        
    }
    
    private func setupSaveButton() {
        view.addSubview(saveButton)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        saveButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftInset - 200).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -rightInset).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -54.0).isActive = true
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc private func saveButtonTapped() {
        print("Save")
    }
}
