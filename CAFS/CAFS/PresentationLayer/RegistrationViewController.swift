import UIKit

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}

class RegistrationViewController: UIViewController {
    
    // MARK: - Views
    
    private let registrationStackView = UIStackView()
    private let titleLabel = UILabel()
    private let emailTextField = UnderlineTextField()
    private let passwordTextField = UnderlineTextField()
    private let repeatPasswordTextField = UnderlineTextField()
    private let errorLabel = UILabel()
    private let firstNameTextField = UnderlineTextField()
    private let secondNameTextField = UnderlineTextField()
    private let universityTextField = UnderlineTextField()
    private let loginButton = HseStyleButton()
    private let registerButton = HseStyleButton()
    
    private let checkBoxView = UIView()
    private let statusStudentButton = CheckBoxButton()
    private let statusTeacherButton = CheckBoxButton()
    
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
    
    lazy private var userManager = UserManager()
    
    // MARK: - Private methods
    private func setupViews() {
        setupRegistrationLabel()
        setupRegisterButton()
        setupStackView()
    }
    
    private func setupStackView() {
        view.addSubview(registrationStackView)
        
        registrationStackView.translatesAutoresizingMaskIntoConstraints = false
        
        registrationStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: rightInset).isActive = true
        registrationStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftInset).isActive = true
        registrationStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 184.0).isActive = true
        
        firstNameTextField.placeholder = "Имя"
        secondNameTextField.placeholder = "Фамилия"
        universityTextField.placeholder = "Университет"
        emailTextField.placeholder = "Введите e-mail"
        passwordTextField.placeholder = "Введите пароль"
        repeatPasswordTextField.placeholder = "Повторите пароль"
        errorLabel.textColor = UIColor.systemRed
        
        checkBoxView.addSubview(statusTeacherButton)
        checkBoxView.addSubview(statusStudentButton)
        
        registrationStackView.addArrangedSubview(firstNameTextField)
        registrationStackView.addArrangedSubview(secondNameTextField)
        registrationStackView.addArrangedSubview(universityTextField)
        registrationStackView.addArrangedSubview(checkBoxView)
        registrationStackView.addArrangedSubview(emailTextField)
        registrationStackView.addArrangedSubview(passwordTextField)
        registrationStackView.addArrangedSubview(repeatPasswordTextField)
        registrationStackView.addArrangedSubview(errorLabel)
        registrationStackView.axis = .vertical
        registrationStackView.spacing = 50.0
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    private func setupRegistrationLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "Регистрация"
        titleLabel.textColor = UIColor.hseBlue
        titleLabel.font = UIFont.systemFont(ofSize: 32.0, weight: .bold)
        
        titleLabel.heightAnchor.constraint(equalToConstant: 36.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: rightInset).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftInset).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60.0).isActive = true
        
    }
    
    private func setupRegisterButton() {
        view.addSubview(registerButton)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registerButton.setTitle("Зарегистрироваться", for: .normal)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        registerButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftInset).isActive = true
        registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -rightInset).isActive = true
        registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -54.0).isActive = true
    }
    
    private func isPersonalDataValid(_ completion: @escaping (_ isUserDataValid: Bool?) -> Void) {
        var isFreeEmail = false
        var isGoodPassword = false
        
        
        if let firstname = self.firstNameTextField.text {
            if firstname.isEmpty {
                self.firstNameTextField.attributedPlaceholder = NSAttributedString(string: "Введите ваше имя", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed])
            }
        }
        
        
        
        if let secondname = self.secondNameTextField.text {
            if  secondname.isEmpty {
                self.secondNameTextField.attributedPlaceholder = NSAttributedString(string: "Введите вашу фамилию", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed])
            }
        }
        
        
        if let university = self.universityTextField.text {
            if  university.isEmpty {
                self.universityTextField.attributedPlaceholder = NSAttributedString(string: "Введите ваш университет", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed])
            }
        }
        
        if let password = self.passwordTextField.text {
            if  password.isEmpty {
                self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "Введите ваш пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed])
            } else if let repeatPassword = self.repeatPasswordTextField.text {
                if password == repeatPassword {
                    isGoodPassword = true
                }
                else {
                    self.errorLabel.text = "Пароли не совпадают"
                }
            }
        }
        
        if let email = self.emailTextField.text {
            if  email.isEmpty {
                self.emailTextField.attributedPlaceholder = NSAttributedString(string: "Введите ваш email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed])
            } else if !email.isValidEmail() {
                self.errorLabel.text = "Некорректный email"
            } else {
                self.userManager.isUserExist(id: PersonalData.getId(email: email)) { result in
                    if let result = result {
                        if result {
                            print("isUserExist in checkValid", result)
                            self.errorLabel.text = "Данный пользователь уже существует"
                        } else {
                            isFreeEmail = true
                        }
                    } else {
                        isFreeEmail = true
                    }
                    
                    if isFreeEmail && isGoodPassword {
                        completion(true)
                    } else {
                        completion(nil)
                    }
                }
            }
        }
    }
    
    @objc private func registerButtonTapped() {
        do {
            isPersonalDataValid() { [self] isValid in
                if let isValid = isValid {
                    print("Validating before adding", isValid)
                    let personalData = PersonalData()
                    personalData.firstname = firstNameTextField.text!
                    personalData.lastname = secondNameTextField.text!
                    personalData.university = universityTextField.text!
                    personalData.setEmailAndPassword(email: emailTextField.text!, password: passwordTextField.text!)
                    userManager.addNewUser(personalData: personalData) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            navigationController?.pushViewController(MainTabBarController(), animated: true)
                            print("Success adding document")
                        }
                    }
                }
            }
        }
        
        print("Register")
    }
}
