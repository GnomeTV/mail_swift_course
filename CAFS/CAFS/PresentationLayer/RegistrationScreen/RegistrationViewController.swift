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
        setupViews()
        setupSpinner()
    }
    
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
//        statusStudentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftInset).isActive = true
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
        
        var isFreeEmail = false
        var isGoodPassword = false
        
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
                completion(isFreeEmail && isGoodPassword)
            }
        }
    }
    
    @objc private func registerButtonTapped() {
        spinner.startAnimating()
        
        let firstname = firstNameTextField.text ?? ""
        let secondname = secondNameTextField.text ?? ""
        let university = universityTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let personalData = PersonalData(firstName: firstname, lastName: secondname, university: university, email: email, password: password)
        
        isPersonalDataValid(personalData) { [self] isValid in
            if isValid {
                DispatchQueue.main.async {
                    model.addNewUser(personalData: personalData) { isDone in
                        if isDone {
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
