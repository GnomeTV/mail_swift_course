import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Views
    private let titleLabel = UILabel()
    private let emailTextField = UITextField()
    private let emailIndicatorView = UIView()
    private let passwordTextField = UITextField()
    private let passwordIndicatorView = UIView()
    private let loginButton = HseStyleButton()
    private let registerButton = HseStyleButton()
    
    // MARK: - Insets
    private let leftInset: CGFloat = 24.0
    private let rightInset: CGFloat = 24.0
    private let buttonHeight: CGFloat = 48.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    // MARK: - Private methods
    
    private func setupViews() {
        setupRegisterButton()
        setupLoginButton()
        setupLoginLabel()
        setupLoginPasswordTextField()
        positionTextFieldIndicators()
        
    }
    private func setupLoginPasswordTextField() {
            view.addSubview(emailTextField)
            view.addSubview(passwordTextField)
            
            emailTextField.translatesAutoresizingMaskIntoConstraints = false
            passwordTextField.translatesAutoresizingMaskIntoConstraints = false
            
            emailTextField.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0).isActive = true
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0).isActive = true
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -128.0).isActive = true
            
            emailTextField.placeholder = "Введите e-mail"
            emailTextField.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
            emailTextField.textColor = .black
            emailTextField.borderStyle = .none
            
            passwordTextField.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0).isActive = true
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0).isActive = true
            passwordTextField.centerYAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 64.0).isActive = true
            
            passwordTextField.placeholder = "Введите пароль"
            passwordTextField.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
            passwordTextField.textColor = .black
            passwordTextField.borderStyle = .none
    }
    
    private func positionTextFieldIndicators() {
        emailIndicatorView.backgroundColor = UIColor.hseBlue
        passwordIndicatorView.backgroundColor = UIColor.hseBlue
        
        view.addSubview(passwordIndicatorView)
        view.addSubview(emailIndicatorView)
        emailIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        passwordIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        emailIndicatorView.heightAnchor.constraint(equalToConstant: 2.0).isActive = true
        emailIndicatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftInset).isActive = true
        emailIndicatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -rightInset).isActive = true
        emailIndicatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 3.0).isActive = true
        
        passwordIndicatorView.heightAnchor.constraint(equalToConstant: 2.0).isActive = true
        passwordIndicatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftInset).isActive = true
        passwordIndicatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -rightInset).isActive = true
        passwordIndicatorView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 3.0).isActive = true
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
    
    @objc private func loginButtonTapped() {
        print("Login")
    }
    
    @objc private func registerButtonTapped() {
        print("Register")
    }
    
}
