import UIKit

class RegistrationViewController: UIViewController {
    
    // MARK: - Views
    
    let profileViewController = ProfileViewController()
    private let titleLabel = UILabel()
    private let emailTextField = UITextField()
    private let emailIndicatorView = UIView()
    private let passwordTextField = UITextField()
    private let passwordIndicatorView = UIView()
    private let repeatPasswordTextField = UITextField()
    private let repeatPasswordIndicatorView = UIView()
    private let loginButton = HseStyleButton()
    private let registerButton = HseStyleButton()
    
    // MARK: - Insets
    
    private let leftInset: CGFloat = 24.0
    private let rightInset: CGFloat = 24.0
    private let buttonHeight: CGFloat = 48.0
    private let textFieldHeight: CGFloat = 24.0
    private let indicatorHeight: CGFloat = 2.0
    private let topInsetTextFieldIndicator: CGFloat = 3.0
    private let fontSizeTextField: CGFloat = 20.0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    
    // MARK: - Private methods
    private func setupViews() {
        setupLoginPasswordTextField()
        positionTextFieldIndicators()
        setupRegistrationLabel()
        setupRegisterButton()
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
    
    private func setupLoginPasswordTextField() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(repeatPasswordTextField)
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        repeatPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        emailTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftInset).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -rightInset).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -128.0).isActive = true
        
        emailTextField.placeholder = "Введите e-mail"
        emailTextField.font = UIFont.systemFont(ofSize: fontSizeTextField, weight: .regular)
        emailTextField.textColor = .black
        emailTextField.borderStyle = .none
        
        passwordTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftInset).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -rightInset).isActive = true
        passwordTextField.centerYAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 64.0).isActive = true
        
        passwordTextField.placeholder = "Введите пароль"
        passwordTextField.font = UIFont.systemFont(ofSize: fontSizeTextField, weight: .regular)
        passwordTextField.textColor = .black
        passwordTextField.borderStyle = .none
        
        repeatPasswordTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
        repeatPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftInset).isActive = true
        repeatPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -rightInset).isActive = true
        repeatPasswordTextField.centerYAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 64.0).isActive = true
        
        repeatPasswordTextField.placeholder = "Повторите пароль"
        repeatPasswordTextField.font = UIFont.systemFont(ofSize: fontSizeTextField, weight: .regular)
        repeatPasswordTextField.textColor = .black
        repeatPasswordTextField.borderStyle = .none
        
            
    }
    private func positionTextFieldIndicators() {
        emailIndicatorView.backgroundColor = UIColor.hseBlue
        passwordIndicatorView.backgroundColor = UIColor.hseBlue
        repeatPasswordIndicatorView.backgroundColor = UIColor.hseBlue
        
        
        view.addSubview(passwordIndicatorView)
        view.addSubview(emailIndicatorView)
        view.addSubview(repeatPasswordIndicatorView)
        
        emailIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        passwordIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        repeatPasswordIndicatorView.translatesAutoresizingMaskIntoConstraints = false

        
        emailIndicatorView.heightAnchor.constraint(equalToConstant: indicatorHeight).isActive = true
        emailIndicatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftInset).isActive = true
        emailIndicatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -rightInset).isActive = true
        emailIndicatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: topInsetTextFieldIndicator).isActive = true
        
        passwordIndicatorView.heightAnchor.constraint(equalToConstant: indicatorHeight).isActive = true
        passwordIndicatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftInset).isActive = true
        passwordIndicatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -rightInset).isActive = true
        passwordIndicatorView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: topInsetTextFieldIndicator).isActive = true
        
        repeatPasswordIndicatorView.heightAnchor.constraint(equalToConstant: indicatorHeight).isActive = true
        repeatPasswordIndicatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftInset).isActive = true
        repeatPasswordIndicatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -rightInset).isActive = true
        repeatPasswordIndicatorView.topAnchor.constraint(equalTo: repeatPasswordTextField.bottomAnchor, constant: topInsetTextFieldIndicator).isActive = true
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
        
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    @objc private func registerButtonTapped() {
        profileViewController.modalPresentationStyle = .fullScreen
        present(profileViewController, animated: true, completion: nil)
        print("Register")
    }
}
