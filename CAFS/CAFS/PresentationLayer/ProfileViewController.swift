import UIKit

class ProfileViewController: UIViewController {
    
    
    // MARK: - Views
    private let firstnameTextField = UITextField()
    private let firstnameIndicatorView = UIView()
    private let lastnameTextField = UITextField()
    private let lastnameIndicatorView = UIView()
    private let bornTextField = UITextField()
    private let bornIndicatorView = UIView()
    private let universityTextField = UITextField()
    private let universityIndicatorView = UIView()
    private let profilePhoto = UIImage()
    private let profilePhotoView = UIImageView()
    private let preferencesButton = HseStyleButton()
       
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
        
        self.title = "Профиль"
        
        view.backgroundColor = .white
        setupViews()
    }
       
       
       // MARK: - Private methods
    private func setupViews() {
        setupSelfinfoLabel()
    }
       
    private func setupSelfinfoLabel() {
        view.addSubview(firstnameTextField)
        view.addSubview(lastnameTextField)
        view.addSubview(bornTextField)
        view.addSubview(universityTextField)
        
        firstnameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastnameTextField.translatesAutoresizingMaskIntoConstraints = false
        bornTextField.translatesAutoresizingMaskIntoConstraints = false
        universityTextField.translatesAutoresizingMaskIntoConstraints = false
        
    }
       
}
