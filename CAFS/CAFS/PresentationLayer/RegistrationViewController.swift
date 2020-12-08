import UIKit

extension Optional where Wrapped == String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}

class RegistrationViewController: UIViewController, checkBoxDelegate {
    func didTapCheckbox(isChecked: Bool, type: String) {
        switch type {
        case "student":
            print("student")
            statusTeacherButton.isChecked = false
        default:
            print("teacher")
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
    private let universityiTextField = UnderlineTextField()
    private let loginButton = HseStyleButton()
    private let registerButton = HseStyleButton()
    
    private let checkBoxView = UIView()
    private let statusStudentButton = CheckBoxButton()
    private let statusStudentLabel = UILabel()
    private let statusTeacherButton = CheckBoxButton()
    private let statusTeacherLabel = UILabel()
    
    // MARK: - Insets
    
    private let leftInset: CGFloat = 24.0
    private let rightInset: CGFloat = 24.0
    private let buttonHeight: CGFloat = 48.0
    private let topInsetTextFieldIndicator: CGFloat = 3.0
    private let topInsetCheckBoxButton: CGFloat = 20.0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
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
        universityiTextField.placeholder = "Университет"
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
        registrationStackView.addArrangedSubview(universityiTextField)
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
    
    private func isPersonalDataValid() -> Bool {
        
        if firstNameTextField.text == "" {
            firstNameTextField.attributedPlaceholder = NSAttributedString(string: "Введите имя", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed])
        }
        
        if secondNameTextField.text == "" {
            secondNameTextField.attributedPlaceholder = NSAttributedString(string: "Введите фамилию", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed])
        }
        
        if universityiTextField.text == "" {
            universityiTextField.attributedPlaceholder = NSAttributedString(string: "Введите университет", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed])
        }
        
        if emailTextField.text == "" {
            emailTextField.attributedPlaceholder = NSAttributedString(string: "Введите email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed])
        }
        
        if passwordTextField.text == "" {
            passwordTextField.attributedPlaceholder = NSAttributedString(string: "Введите пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed])
        }

        
        if passwordTextField.text == repeatPasswordTextField.text && passwordTextField.text != "" && emailTextField.text.isValidEmail() {
            let firestoreManager = FirestoreManager()
            let personalData = PersonalData()
            personalData.setFirstname(firstname: firstNameTextField.text ?? "default")
            personalData.setLastname(lastname: secondNameTextField.text ?? "default")
            personalData.setUniversity(university: universityiTextField.text ?? "default")
            personalData.setEmail(email: emailTextField.text ?? "default")
            personalData.setPassword(password: passwordTextField.text ?? "default")
            firestoreManager.addNewUser(personalData: personalData)
            
            return true
        }
        else if passwordTextField.text != repeatPasswordTextField.text{
            errorLabel.text = "Пароли не совпадают"
            return false
        }
        
        else if !emailTextField.text.isValidEmail() {
            errorLabel.text = "Некорректный email"
            return false
        }
        
        return false
    }
    
    @objc private func registerButtonTapped() {
        
        if isPersonalDataValid() {
            navigationController?.pushViewController(MainTabBarController(), animated: true)
        }
        
        print("Register")
    }
}
