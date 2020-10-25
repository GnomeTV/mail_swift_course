import UIKit

class AuthorizationViewController: UIViewController {
    
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton()
    private let registrationButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        createLoginLabel()
        createAndPositionTextField()
        createAndPositionTextFieldIndicator()
        createAndPositionLoginButton()
    }
    
    private func createAndPositionTextField() {
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
    
    private func createAndPositionTextFieldIndicator() {
        let indicatorEmailView = UIView()
        let indicatorPasswordView = UIView()
        indicatorEmailView.backgroundColor = UIColor.hseBlue
        indicatorPasswordView.backgroundColor = UIColor.hseBlue
        
        view.addSubview(indicatorPasswordView)
        view.addSubview(indicatorEmailView)
        indicatorEmailView.translatesAutoresizingMaskIntoConstraints = false
        indicatorPasswordView.translatesAutoresizingMaskIntoConstraints = false
        
        indicatorEmailView.heightAnchor.constraint(equalToConstant: 2.0).isActive = true
        indicatorEmailView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0).isActive = true
        indicatorEmailView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0).isActive = true
        indicatorEmailView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 3.0).isActive = true
        
        indicatorPasswordView.heightAnchor.constraint(equalToConstant: 2.0).isActive = true
        indicatorPasswordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0).isActive = true
        indicatorPasswordView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0).isActive = true
        indicatorPasswordView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 3.0).isActive = true
    }
    
    private func createLoginLabel() {
        let titleLabel = UILabel()
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "Вход"
        titleLabel.textColor = UIColor.hseBlue
        titleLabel.font = UIFont.systemFont(ofSize: 32.0, weight: .bold)
        
        titleLabel.heightAnchor.constraint(equalToConstant: 36.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 48.0).isActive = true
    }
    
    private func createAndPositionLoginButton() {
        view.addSubview(loginButton)
        view.addSubview(registrationButton)
        
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -92.0).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
        
        registrationButton.bottomAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 52.0).isActive = true
        registrationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0).isActive = true
        registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0).isActive = true
        registrationButton.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
        
        registrationButton.setTitle("Зарегистрироваться", for: .normal)
        loginButton.setTitle("Войти", for: .normal)
        [
            registrationButton,
            loginButton,
        ].forEach({
            $0.layer.cornerRadius = 7
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: .bold)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = UIColor.hseBlue
        })
        
        
        
        
    }
}
