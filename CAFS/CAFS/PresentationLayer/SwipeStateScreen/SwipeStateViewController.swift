import UIKit

class SwipeStateViewController: UIViewController {
    private let titleLabel = UILabel()
    
    // MARK: - Insets
    
    private let leftInset: CGFloat = 24.0
    private let rightInset: CGFloat = 24.0
    private let buttonHeight: CGFloat = 48.0
    private let topInsetTextFieldIndicator: CGFloat = 3.0
    
    private let screenRect = UIScreen.main.bounds
    
    let model = viewModels.swipeStateViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupViews()
    }
    
    private func setupViews() {
        setupSwipeStateLabel()
        updateView()
    }
    
    private func setupSwipeStateLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "Ждите"
        titleLabel.textColor = UIColor.hseBlue
        titleLabel.font = UIFont.systemFont(ofSize: 32.0, weight: .bold)
        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        titleLabel.textAlignment = .center
    }
    
    private func updateView() {
        if let userData = model.getUserInfo() {
            model.checkQueueSwipeState(currentUser: userData) { error in
                if error != nil {
                    self.titleLabel.lineBreakMode = .byWordWrapping
                    self.titleLabel.numberOfLines = 0
                    self.titleLabel.text = "Вы уже просмотрели\nвсех пользователей"
                } else {
                    self.navigationController?.pushViewController(SelectionViewController(), animated: false)
                }
            }
        }
    }
}
