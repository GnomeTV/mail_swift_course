import UIKit

class PreferencesViewController: UIViewController {
    
    // MARK: - Views
    
    private let preferencesStackView = UIStackView()
    private let scrollView = UIScrollView()
    private let titleLabel = UILabel()
    private let exitButton = HseStyleButton()
    
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
    
    private let model = viewModels.preferencesViewModel
    
    // MARK: - Private methods
    private func setupViews() {
        setupTitleLabel()
        setupExitButton()
    }
    
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "Настройки"
        titleLabel.textColor = UIColor.hseBlue
        titleLabel.font = UIFont.systemFont(ofSize: 32.0, weight: .bold)
        
        titleLabel.heightAnchor.constraint(equalToConstant: 36.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: rightInset).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftInset).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60.0).isActive = true
    }
    
    private func setupExitButton() {
        view.addSubview(exitButton)
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        exitButton.setTitle("Выйти из аккаунта", for: .normal)
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        
        exitButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftInset).isActive = true
        exitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -rightInset).isActive = true
        exitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -buttonHeight*2).isActive = true
    }
    
    @objc private func exitButtonTapped() {
        model.clearUser()
        self.navigationController?.tabBarController?.tabBar.removeFromSuperview()
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
}

