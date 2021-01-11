import UIKit

class PreferencesViewController: UIViewController {
    
    // MARK: - Views
    
    private let preferencesStackView = UIStackView()
    private let scrollView = UIScrollView()
    private let titleLabel = UILabel()
    private let exitButton = HseStyleButton()
    
    private let darkThemeButton = HseStyleButton()
    private let lightThemeButton = HseStyleButton()
    
    // MARK: - Insets
    
    private let leftInset: CGFloat = 24.0
    private let rightInset: CGFloat = 24.0
    private let buttonHeight: CGFloat = 48.0
    private let topInsetTextFieldIndicator: CGFloat = 3.0
    private let topInsetCheckBoxButton: CGFloat = 20.0
    
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
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
        setupOptionsStackView()
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
    
    private func setupOptionsStackView() {
        
        view.addSubview(lightThemeButton)
        view.addSubview(darkThemeButton)
    
        lightThemeButton.addTarget(self, action: #selector(switchButtonTapped), for: .touchUpInside)
        lightThemeButton.setTitle("Светлая", for: .normal)
        lightThemeButton.translatesAutoresizingMaskIntoConstraints = false
        
        lightThemeButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40).isActive = true
        lightThemeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftInset).isActive = true
        lightThemeButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        lightThemeButton.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenWidth / 2).isActive = true
        
        darkThemeButton.addTarget(self, action: #selector(switchButtonTapped), for: .touchUpInside)
        darkThemeButton.setTitle("Тёмная", for: .normal)
        darkThemeButton.translatesAutoresizingMaskIntoConstraints = false
        darkThemeButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40).isActive = true
        darkThemeButton.leadingAnchor.constraint(equalTo: lightThemeButton.trailingAnchor).isActive = true
        darkThemeButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        darkThemeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -rightInset).isActive = true

    }
    
    @objc private func exitButtonTapped() {
        model.clearUser()
        self.navigationController?.tabBarController?.tabBar.removeFromSuperview()
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    @objc private func switchButtonTapped(sender: HseStyleButton) {
        if sender == lightThemeButton {
            lightThemeButton.isSelected = true
            darkThemeButton.isSelected = false
            lightThemeButton.backgroundColor = UIColor.hseBlue
            darkThemeButton.backgroundColor = .gray
        }
        else if sender == darkThemeButton {
            lightThemeButton.isSelected = false
            darkThemeButton.isSelected = true
            darkThemeButton.backgroundColor = UIColor.hseBlue
            lightThemeButton.backgroundColor = .gray
        }
    }
}

