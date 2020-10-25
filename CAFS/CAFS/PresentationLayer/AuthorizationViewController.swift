import UIKit

class AuthorizationViewController: UIViewController {
    
    private let emailTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        createTitleLabel()
        createAndPositionTextField()
        createAndPositionTextFieldIndicator()
    }
    
    private func createAndPositionTextField() {
        view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        emailTextField.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        emailTextField.placeholder = "Сюда надо вводить мыло"
        emailTextField.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        emailTextField.textColor = .black
        emailTextField.borderStyle = .none
    }
    
    private func createAndPositionTextFieldIndicator() {
        let indicatorView = UIView()
        indicatorView.backgroundColor = UIColor.hseBlue
        
        view.addSubview(indicatorView)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        indicatorView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        indicatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0).isActive = true
        indicatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0).isActive = true
        indicatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 2.0).isActive = true
    }
    
    private func createTitleLabel() {
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
}
