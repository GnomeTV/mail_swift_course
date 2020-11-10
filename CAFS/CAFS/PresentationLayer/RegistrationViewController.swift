import UIKit

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
    private let universityiTextField = UnderlineTextField()
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
        
        checkBoxView.addSubview(statusTeacherButton)
        checkBoxView.addSubview(statusStudentButton)
        
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
    
    @objc private func registerButtonTapped() {
        if firstNameTextField.text == "" {
            firstNameTextField.attributedPlaceholder = NSAttributedString(string: "Введите ваше имя", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed])
        }
        
        if secondNameTextField.text == "" {
            secondNameTextField.attributedPlaceholder = NSAttributedString(string: "Введите вашу фамилию", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed])
        }
        
        if universityiTextField.text == "" {
            universityiTextField.attributedPlaceholder = NSAttributedString(string: "Введите ваш университет", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed])
        }
        
        if emailTextField.text == "" {
            emailTextField.attributedPlaceholder = NSAttributedString(string: "Введите ваш email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed])
        }
        
        if passwordTextField.text == "" {
            passwordTextField.attributedPlaceholder = NSAttributedString(string: "Введите ваш пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed])
        }
        
        if passwordTextField.text == repeatPasswordTextField.text && passwordTextField.text != "" {
            let firestoreManager = FirestoreManager()
            let personalData = PersonalData()
            personalData.setFirstname(firstname: firstNameTextField.text ?? "default")
            personalData.setLastname(lastname: secondNameTextField.text ?? "default")
            personalData.setUniversity(university: universityiTextField.text ?? "default")
            personalData.setEmail(email: emailTextField.text ?? "default")
            personalData.setPassword(password: passwordTextField.text ?? "default")
            firestoreManager.addNewUser(personalData: personalData)
            
            self.navigationController?.pushViewController(ProfileViewController(), animated: true)
        }
        else {
            errorLabel.text = "Пароли не совпадают"
        }
        
        
        print("Register")
    }
}
