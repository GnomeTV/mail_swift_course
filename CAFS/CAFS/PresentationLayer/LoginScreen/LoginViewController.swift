
import UIKit
import Firebase
import FirebaseFirestoreSwift

class LoginViewController: UIViewController {
    
    // MARK: - Views
    
    private let registrationViewController = RegistrationViewController()
    private let loginStackiew = UIStackView()
    private let titleLabel = UILabel()
    private let emailTextField = UnderlineTextField()
    private let passwordTextField = UnderlineTextField()
    private let errorLabel = UILabel()
    private let loginButton = HseStyleButton()
    private let registerButton = HseStyleButton()
    
    private var spinner = UIActivityIndicatorView(style: .medium)
    
    // MARK: - Insets
    
    private let leftInset: CGFloat = 24.0
    private let rightInset: CGFloat = 24.0
    private let buttonHeight: CGFloat = 48.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    // MARK: - ViewModel
    private let model = viewModels.loginViewModel

    // MARK: - Private methods
    
    private func isUserExist(_ email : String) -> Bool {
        return true
    }
    private func isPasswordValid(_ email : String, _ password : String) -> Bool {
        return true
    }
    
    private func setupViews() {
        setupRegisterButton()
        setupLoginButton()
        setupLoginLabel()
        setupStackView()
    }

    private func setupLoginLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
            
        titleLabel.text = "Вход"
        titleLabel.textColor = UIColor.hseBlue
        titleLabel.font = UIFont.systemFont(ofSize: 32.0, weight: .bold)
            
        titleLabel.heightAnchor.constraint(equalToConstant: 36.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: rightInset).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftInset).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60.0).isActive = true
    }
    
    private func setupStackView() {
        view.addSubview(loginStackiew)
        loginStackiew.translatesAutoresizingMaskIntoConstraints = false
        
        loginStackiew.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: rightInset).isActive = true
        loginStackiew.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftInset).isActive = true
        loginStackiew.topAnchor.constraint(equalTo: view.topAnchor, constant: 326.0).isActive = true
        
        emailTextField.placeholder = "Введите e-mail"
        passwordTextField.placeholder = "Введите пароль"
        passwordTextField.isSecureTextEntry = true
        errorLabel.textColor = UIColor.systemRed
        
        emailTextField.spellCheckingType = .no
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        
        passwordTextField.spellCheckingType = .no
        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        
        loginStackiew.addArrangedSubview(emailTextField)
        loginStackiew.addArrangedSubview(passwordTextField)
        loginStackiew.addArrangedSubview(errorLabel)
        loginStackiew.axis = .vertical
        loginStackiew.spacing = 50.0
    }
    
    private func setupLoginButton() {
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.setTitle("Войти", for: .normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftInset).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -rightInset).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: registerButton.topAnchor, constant: -8.0).isActive = true
    }
    
    private func setupRegisterButton() {
        view.addSubview(registerButton)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registerButton.setTitle("Зарегистрироваться", for: .normal)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        registerButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftInset).isActive = true
        registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -rightInset).isActive = true
        registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -42.0).isActive = true
    }
    
    private func isPersonalDataValid(_ data: PersonalData, _ completion: @escaping (_ isUserDataValid: Bool) -> Void) {
        var isUserExists = false
        if data.password.isEmpty {
            let attrString = NSAttributedString.getAttributedErrorPlaceholder(for: "Введите ваш пароль")
            passwordTextField.attributedPlaceholder = attrString
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
                isUserExists = userExists
                if userExists {
                    errorLabel.text = "Данный пользователь уже существует"
                }
                completion(isUserExists)
            }
        }
    }
    
    @objc private func loginButtonTapped() {
        spinner.startAnimating()
        
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let personalData = PersonalData(firstName: "", lastName: "", university: "", status: "", email: email, password: password)
        
        isPersonalDataValid(personalData) { [self] isValid in
            if isValid {
                self.navigationController?.pushViewController(MainTabBarController(), animated: true)
            } else {
                errorLabel.text = "Не верный логин или пароль"
            }
            spinner.stopAnimating()
        }
    }
    
    @objc private func registerButtonTapped() {
        self.navigationController?.pushViewController(RegistrationViewController(), animated: true)
    }
}
