//
//  MainScreenViewController.swift
//  CAFS
//
//  Created by Павел Травкин on 11.11.2020.
//

import UIKit


class SelectionViewController: UIViewController {

    private let titleLabel = UILabel()
    
    private let profileImageStackView = UIStackView()
    private let profileImageView = UIImageView(image: UIImage(named: "defaultProfilePhoto_image"))
    
    private let personalInfoStackView = UIStackView()
    private let firstnameTextField = UnderlineTextLabel()
    private let lastnameTextField = UnderlineTextLabel()
    private let universityTextField = UnderlineTextLabel()
    private let statusTextField = UnderlineTextLabel()
    
    private let extraInfoStackView = UIStackView()
    private let extraContactTextField = UITextView()
    private let firstWorkNameTextField = UITextView()
    private let secondWorkNameTextField = UITextView()
    private let thirdWorkNameTextField = UITextView()
    
    // MARK: - Insets
    
    private let leftInset: CGFloat = 24.0
    private let rightInset: CGFloat = 24.0
    private let buttonHeight: CGFloat = 48.0
    private let topInsetTextFieldIndicator: CGFloat = 3.0
    
    private let screenRect = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        self.hideKeyboardWhenTappedAround()
        view.backgroundColor = .white
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwiped(_:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwiped(_:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
    }
    
    private let model = viewModels.selectionViewModel
    
    // MARK: - Private methods
    private func setupViews() {
        setupProfileLabel()
        setupProfileImageStackView()
        setupPersonalInfoStackView()
        setupInfoStackView()
    }
    
    private func setupProfileImageStackView() {
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        view.addSubview(profileImageStackView)
        profileImageStackView.addArrangedSubview(profileImageView)
        profileImageStackView.translatesAutoresizingMaskIntoConstraints = false
        profileImageStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: rightInset).isActive = true
        profileImageStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -screenWidth + 200 + leftInset).isActive = true
        profileImageStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 114.0).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -screenHeight + 150 + 200).isActive = true
            
            
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.masksToBounds = true
        
        profileImageStackView.addArrangedSubview(profileImageView)
        profileImageStackView.axis = .vertical
        profileImageStackView.spacing = 10.0
            
        }
        
    private func setupPersonalInfoStackView() {
        view.addSubview(personalInfoStackView)
        let screenWidth = screenRect.size.width
        personalInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        personalInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenWidth - rightInset - 150).isActive = true
        personalInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftInset).isActive = true
        personalInfoStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 114.0).isActive = true
        personalInfoStackView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 360).isActive = true
        
        if let userPersonalData = model.getUserInfo() {
            
            firstnameTextField.text = userPersonalData.firstName
            lastnameTextField.text = userPersonalData.lastName
            universityTextField.text = userPersonalData.university
            statusTextField.text = userPersonalData.status
            
            model.getUserAvatar(user: userPersonalData) { result in
                switch result {
                case .success(let image):
                    self.profileImageView.image = image
                case .failure(_):
                    print("Error download image")
                }
                
            }
        }
        personalInfoStackView.addArrangedSubview(firstnameTextField)
        personalInfoStackView.addArrangedSubview(lastnameTextField)
        personalInfoStackView.addArrangedSubview(universityTextField)
        personalInfoStackView.addArrangedSubview(statusTextField)
        personalInfoStackView.axis = .vertical
        personalInfoStackView.spacing = 50.0
        
    }
    
    private func setupProfileLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "Свайпалка"
        titleLabel.textColor = UIColor.hseBlue
        titleLabel.font = UIFont.systemFont(ofSize: 32.0, weight: .bold)
        
        titleLabel.heightAnchor.constraint(equalToConstant: 36.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: rightInset).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftInset).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60.0).isActive = true
        
    }
    
    private func setupInfoStackView() {
        view.addSubview(extraInfoStackView)
        
        extraInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        extraInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: rightInset).isActive = true
        extraInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftInset).isActive = true
        extraInfoStackView.topAnchor.constraint(equalTo: personalInfoStackView.bottomAnchor, constant: 20).isActive = true
        extraInfoStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300).isActive = true
        
        extraContactTextField.text = "Дополнительный контакт"
        firstWorkNameTextField.text = "Название первой работы"
        secondWorkNameTextField.text = "Название второй работы"
        thirdWorkNameTextField.text = "Название третьей работы"
        
        extraInfoStackView.addArrangedSubview(extraContactTextField)
        extraInfoStackView.addArrangedSubview(firstWorkNameTextField)
        extraInfoStackView.addArrangedSubview(secondWorkNameTextField)
        extraInfoStackView.addArrangedSubview(thirdWorkNameTextField)
        
        extraInfoStackView.axis = .vertical
        extraInfoStackView.spacing = 10.0
    }

    @objc private func leftSwiped(_ gesture: UISwipeGestureRecognizer) {
        view.backgroundColor = .green
        extraContactTextField.backgroundColor = .green
        firstWorkNameTextField.backgroundColor = .green
        secondWorkNameTextField.backgroundColor = .green
        thirdWorkNameTextField.backgroundColor = .green
    }
    
    @objc private func rightSwiped(_ gesture: UISwipeGestureRecognizer) {
        view.backgroundColor = .red
        extraContactTextField.backgroundColor = .red
        firstWorkNameTextField.backgroundColor = .red
        secondWorkNameTextField.backgroundColor = .red
        thirdWorkNameTextField.backgroundColor = .red
        
    }
}
