//
//  PreferencesViewController.swift
//  CAFS
//
//  Created by Павел Травкин on 03.12.2020.
//

import UIKit

class PreferencesViewController: UIViewController {

    private let titleLabel = UILabel()
    
    // MARK: - Insets
    
    private let leftInset: CGFloat = 24.0
    private let rightInset: CGFloat = 24.0
    private let buttonHeight: CGFloat = 48.0
    private let topInsetTextFieldIndicator: CGFloat = 3.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    private let model = viewModels.preferencesViewModel
    
    // MARK: - Private methods
    private func setupViews() {
        setupTitleLabel()
    }
    
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.text = "Настройки"
        titleLabel.textColor = UIColor.hseBlue
        titleLabel.font = UIFont.systemFont(ofSize: 32.0, weight: .bold)

        titleLabel.heightAnchor.constraint(equalToConstant: 36.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: rightInset).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftInset).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60.0).isActive = true
        
    }
    
}

