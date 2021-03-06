import UIKit

class RegistrationViewController: UIViewController, checkBoxDelegate {
    func didTapCheckbox(isChecked: Bool, type: String) {
        switch type {
        case "student":
            statusTeacherButton.isChecked = false
        default:
            statusStudentButton.isChecked = false
        }
        
    }
    
    // MARK: - Views
    
    private let mainScrollView = UIScrollView()
    private let registrationStackView = UIStackView()
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
    private let statusStudentLabel = UILabel()
    private let statusTeacherButton = CheckBoxButton()
    private let statusTeacherLabel = UILabel()
    
    private var spinner = UIActivityIndicatorView(style: .medium)
    
    // MARK: - Insets
    private let leftInset: CGFloat = 24.0
    private let rightInset: CGFloat = 24.0
    private let buttonHeight: CGFloat = 48.0
    private let topInsetTextFieldIndicator: CGFloat = 3.0
    
    // MARK: - ViewModel
    private let model = viewModels.registrationViewModel
    
    private let topInsetCheckBoxButton: CGFloat = 20.0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.hideKeyboardWhenTappedAround()
        setupViews()
        setupSpinner()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
        mainScrollView.contentSize = CGSize(width: registrationStackView.frame.width, height: registrationStackView.frame.height)
        }
    
    // MARK: - Private methods
    private func setupViews() {
        setupRegistrationLabel()
        setupStackView()
    }
    
    private func setupStackView() {
        view.addSubview(mainScrollView)
        
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        registrationStackView.translatesAutoresizingMaskIntoConstraints = false
        
//        mainScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: rightInset).isActive = true
//        mainScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftInset).isActive = true
//        mainScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
//        mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 100).isActive = true
//        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[mainScrollView]|", options: .alignAllCenterX, metrics: nil, views: ["mainScrollView": mainScrollView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[mainScrollView]|", options: .alignAllCenterX, metrics: nil, views: ["mainScrollView": mainScrollView]))

        mainScrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[registrationStackView]|", options: NSLayoutConstraint.FormatOptions.alignAllCenterX, metrics: nil, views: ["registrationStackView": registrationStackView]))
        mainScrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[registrationStackView]", options: NSLayoutConstraint.FormatOptions.alignAllCenterX, metrics: nil, views: ["registrationStackView": registrationStackView]))


//        registrationStackView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor).isActive = true
//        registrationStackView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor).isActive = true
//        registrationStackView.topAnchor.constraint(equalTo: mainScrollView.topAnchor).isActive = true
//        registrationStackView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor).isActive = true
        
        firstNameTextField.placeholder = "Имя"
        secondNameTextField.placeholder = "Фамилия"
        universityTextField.placeholder = "Университет"
        emailTextField.placeholder = "Введите e-mail"
        passwordTextField.placeholder = "Введите пароль"
        repeatPasswordTextField.placeholder = "Повторите пароль"
        errorLabel.textColor = UIColor.systemRed
        
        emailTextField.spellCheckingType = .no
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        
        passwordTextField.spellCheckingType = .no
        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        
        repeatPasswordTextField.spellCheckingType = .no
        repeatPasswordTextField.autocorrectionType = .no
        repeatPasswordTextField.autocapitalizationType = .none
        repeatPasswordTextField.isSecureTextEntry = true
        
        checkBoxView.addSubview(statusStudentButton)
        statusStudentButton.translatesAutoresizingMaskIntoConstraints = false
        statusStudentButton.topAnchor.constraint(equalTo: checkBoxView.topAnchor, constant: topInsetCheckBoxButton).isActive = true
        statusStudentButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        statusStudentButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        statusStudentButton.delegate = self
        statusStudentButton.type = "student"
        statusStudentButton.isChecked = false

        checkBoxView.addSubview(statusStudentLabel)
        statusStudentLabel.translatesAutoresizingMaskIntoConstraints = false
        statusStudentLabel.text = "Студент"
        statusStudentLabel.textColor = UIColor.hseBlue
        statusStudentLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)

        statusStudentLabel.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
        statusStudentLabel.leadingAnchor.constraint(equalTo: statusStudentButton.leadingAnchor, constant: 40.0).isActive = true
        statusStudentLabel.topAnchor.constraint(equalTo: checkBoxView.topAnchor, constant: 27.0).isActive = true
        
        checkBoxView.addSubview(statusTeacherButton)
        statusTeacherButton.translatesAutoresizingMaskIntoConstraints = false
        statusTeacherButton.topAnchor.constraint(equalTo: checkBoxView.topAnchor, constant: topInsetCheckBoxButton).isActive = true
        statusTeacherButton.leadingAnchor.constraint(equalTo: statusStudentLabel.trailingAnchor, constant: 40.0).isActive = true
        statusTeacherButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        statusTeacherButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        statusTeacherButton.delegate = self
        statusTeacherButton.type = "teacher"
        statusTeacherButton.isChecked = false
        
        checkBoxView.addSubview(statusTeacherLabel)
        statusTeacherLabel.translatesAutoresizingMaskIntoConstraints = false
        statusTeacherLabel.text = "Преподаватель"
        statusTeacherLabel.textColor = UIColor.hseBlue
        statusTeacherLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)

        statusTeacherLabel.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
        statusTeacherLabel.leadingAnchor.constraint(equalTo: statusTeacherButton.leadingAnchor, constant: 40.0).isActive = true
        statusTeacherLabel.topAnchor.constraint(equalTo: checkBoxView.topAnchor, constant: 27.0).isActive = true
        
        checkBoxView.translatesAutoresizingMaskIntoConstraints = false
        checkBoxView.heightAnchor.constraint(equalToConstant: 80).isActive = true

        
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
        
        mainScrollView.addSubview(registrationStackView)
        
        view.addSubview(registerButton)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registerButton.setTitle("Зарегистрироваться", for: .normal)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        registerButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftInset).isActive = true
        registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -rightInset).isActive = true
        registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -54.0).isActive = true
    
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    private func setupRegistrationLabel() {
        self.navigationItem.title = "Регистрация"
    }
    
    private func setupSpinner() {
        view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        spinner.sizeToFit()
        spinner.hidesWhenStopped = true
        spinner.transform = CGAffineTransform(scaleX: 5, y: 5)
    }
    
    private func isPersonalDataValid(_ data: PersonalData, _ completion: @escaping (_ isUserDataValid: Bool) -> Void) {
        var isFreeEmail = false
        var isGoodPassword = false
        let isAllBaseFieldsNotEmpty = !data.isAnyBaseFieldsEmpty()
        if data.firstName.isEmpty {
            let attrString = NSAttributedString.getAttributedErrorPlaceholder(for: "Введите ваше имя")
            firstNameTextField.attributedPlaceholder = attrString
        }
        
        if data.lastName.isEmpty {
            let attrString = NSAttributedString.getAttributedErrorPlaceholder(for: "Введите вашу фамилию")
            secondNameTextField.attributedPlaceholder = attrString
        }
        
        if  data.university.isEmpty {
            let attrString = NSAttributedString.getAttributedErrorPlaceholder(for: "Введите ваш университет")
            universityTextField.attributedPlaceholder = attrString
        }
        
        if data.status.isEmpty {
            errorLabel.text = "Укажите свой статус"
        }
        
        let repeatPassword =  repeatPasswordTextField.text ?? ""
        if data.password.isEmpty {
            let attrString = NSAttributedString.getAttributedErrorPlaceholder(for: "Введите ваш пароль")
            passwordTextField.attributedPlaceholder = attrString
        } else if !repeatPassword.isEmpty {
            if data.checkPassword(data.email, repeatPassword) {
                isGoodPassword = true
            }
        } else {
            errorLabel.text = "Пароли не совпадают"
        }
        
        if data.email.isEmpty {
            let attrString = NSAttributedString.getAttributedErrorPlaceholder(for: "Введите ваш email")
            emailTextField.attributedPlaceholder = attrString
            completion(false)
        } else if !data.email.isValidEmail() {
            errorLabel.text = "Некорректный email"
            completion(false)
        } else {
            model.userExist(email: data.email) { [self] userExists in
                isFreeEmail = !userExists
                if userExists {
                    errorLabel.text = "Данный пользователь уже существует"
                }
                completion(isFreeEmail && isGoodPassword && isAllBaseFieldsNotEmpty)
            }
        }
    }
    
    private func getStatus() -> String {
        let statusStudent = statusStudentLabel.text ?? ""
        let statusTeacher = statusTeacherLabel.text ?? ""
        if (!statusStudentButton.isChecked && !statusTeacherButton.isChecked) {
            return ""
        } else {
            return statusStudentButton.isChecked ? statusStudent : statusTeacher
        }
    }
    
    @objc private func registerButtonTapped() {
        spinner.startAnimating()
        
        let firstname = firstNameTextField.text ?? ""
        let secondname = secondNameTextField.text ?? ""
        let university = universityTextField.text ?? ""
        let status = getStatus()
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let personalData = PersonalData(firstName: firstname, lastName: secondname, university: university, status: status, email: email, password: password)
        
        isPersonalDataValid(personalData) { [self] isValid in
            if isValid {
                DispatchQueue.main.async {
                    model.addNewUser(personalData: personalData) { isDone in
                        if isDone {
                            model.updateUserInfo(personalData: personalData)
                            navigationController?.pushViewController(MainTabBarController(), animated: true)
                        } else {
                            errorLabel.text = "Что-то пошло не так, попробуйте позже"
                        }
                    }
                }
            }
            spinner.stopAnimating()
        }
    }
}
