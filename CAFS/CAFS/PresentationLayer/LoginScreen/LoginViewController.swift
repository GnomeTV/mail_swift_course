
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    // MARK: - ViewModel
    private let model = viewModels.loginViewModel
    
    // MARK: - Private methods
    
    private func setupViews() {
        setupRegisterButton()
        setupLoginButton()
        setupLoginLabel()
        setupStackView()
        setupSpinner()
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
    
    private func setupSpinner() {
        view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        spinner.sizeToFit()
        spinner.hidesWhenStopped = true
        spinner.transform = CGAffineTransform(scaleX: 5, y: 5)
    }
    
    private func isPersonalDataValid(_ email: String, _ password: String, _ completion: @escaping (_ isUserDataValid: Bool, _ personalData: PersonalData?) -> Void) {
        let data = PersonalData(firstName: "", lastName: "", university: "", status: "", email: email, password: password)
        
        if data.password.isEmpty {
            let attrString = NSAttributedString.getAttributedErrorPlaceholder(for: "Введите ваш пароль")
            passwordTextField.attributedPlaceholder = attrString
        }
        
        if data.email.isEmpty {
            let attrString = NSAttributedString.getAttributedErrorPlaceholder(for: "Введите ваш email")
            emailTextField.attributedPlaceholder = attrString
            completion(false, nil)
        } else if !data.email.isValidEmail() {
            errorLabel.text = "Некорректный email"
            completion(false, nil)
        } else {
            model.getUserData(email: data.email) { result in
                switch result {
                case .success(let personalData):
                    completion(true, personalData)
                case .failure(_):
                    completion(false, nil)
                }
            }
        }
    }
    
    @objc private func loginButtonTapped() {
        spinner.startAnimating()
        
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        isPersonalDataValid(email, password) { [self] isValid, userData in
            if isValid {
                print("Before updating")
                model.updateUserInfo(personalData: userData!)
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
