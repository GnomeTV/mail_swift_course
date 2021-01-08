import UIKit

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showImagePickerControllerActionSheet() {
        let photoLibraryAction = UIAlertAction(title: "Открыть", style: .default) {
            (action) in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        let cameraAction = UIAlertAction(title: "Создать", style: .default) {
            (action) in
            self.showImagePickerController(sourceType: .camera)
        }
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        
        UIAlertController.showAlert(style: .actionSheet, title: "Выберете фото", message: nil, actions: [photoLibraryAction, cameraAction, cancelAction], completion: nil)
        
    }
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profileImageView.image = editedImage
        }
        else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImageView.image = originalImage
        }
        DispatchQueue.main.async {
            self.updateProfilePhoto() { error in
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func updateProfilePhoto(_ completion: @escaping (Bool) -> Void) {
        let avatar = profileImageView.image?.pngData() ?? Data()
        if avatar.isEmpty {
            completion(false)
        } else {
            if var userInfo = model.getUserInfo() {
                model.addUserAvatar(user: userInfo, avatar: avatar) { result in
                    switch result {
                    case .success((_, let url)):
                        let imageURL = url.absoluteString
                        if imageURL.isEmpty {
                            userInfo.avatar = imageURL
                            self.model.updateUserInfo(personalData: userInfo)
                            completion(true)
                        }
                    case .failure(_):
                        completion(false)
                    }
                }
            }
        }
    }
    
}


class ProfileViewController: UIViewController {
    
    private let titleLabel = UILabel()
    
    private let profileImageStackView = UIStackView()
    private let profileImageView = UIImageView(image: UIImage(named: "defaultProfilePhoto_image"))
    private let profileImageButton = UIButton()
    private let preferencesButton = UIButton()
    
    private let personalInfoStackView = UIStackView()
    private let firstnameTextField = UnderlineTextLabel()
    private let lastnameTextField = UnderlineTextLabel()
    private let universityTextField = UnderlineTextLabel()
    private let statusTextField = UnderlineTextLabel()
    
    private let infoView = UIView()
    private let infoScrollView = UIScrollView()
    private let infoTextView = UITextView()
    
    // MARK: - Insets
    
    private let leftInset: CGFloat = 24.0
    private let rightInset: CGFloat = 24.0
    private let buttonHeight: CGFloat = 48.0
    private let topInsetTextFieldIndicator: CGFloat = 3.0
    
    private let screenRect = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    private let model = viewModels.profileViewModel
    
    // MARK: - Private methods
    private func setupViews() {
        setupProfileLabel()
        setupProfileImageStackView()
        setupPersonalInfoStackView()
        setupInfoStackView()
    }
    
    private func setupProfileImageStackView() {
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        view.addSubview(profileImageStackView)
        profileImageStackView.addArrangedSubview(profileImageView)
        profileImageStackView.translatesAutoresizingMaskIntoConstraints = false
        profileImageStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: rightInset).isActive = true
        profileImageStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -screenWidth + 200 + leftInset).isActive = true
        profileImageStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 114.0).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -screenHeight + 150 + 200).isActive = true
        
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.masksToBounds = true
        
        profileImageButton.translatesAutoresizingMaskIntoConstraints = false
        profileImageButton.setImage(UIImage(named: "addimage_icon"), for: .normal)
        profileImageButton.layer.masksToBounds = true
        profileImageButton.addTarget(self, action: #selector(profileImageButtonTapped), for: .touchUpInside)
        
        profileImageStackView.addArrangedSubview(profileImageView)
        profileImageStackView.addArrangedSubview(profileImageButton)
        profileImageStackView.axis = .vertical
        profileImageStackView.spacing = 10.0
        
    }
    
    private func setupPersonalInfoStackView() {
        view.addSubview(personalInfoStackView)
        let screenWidth = screenRect.size.width
        personalInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        personalInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenWidth - rightInset - 150).isActive = true
        personalInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftInset).isActive = true
        personalInfoStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 114.0).isActive = true
        
        if let userPersonalData = model.getUserInfo() {
            
            firstnameTextField.text = userPersonalData.firstName
            lastnameTextField.text = userPersonalData.lastName
            universityTextField.text = userPersonalData.university
            statusTextField.text = userPersonalData.status
            
            model.getUserAvatar(user: userPersonalData) { result in
                switch result {
                case .success(let image):
                    self.profileImageView.image = image
                case .failure(_):
                    print("Error download image")
                }
                
            }
        }
        personalInfoStackView.addArrangedSubview(firstnameTextField)
        personalInfoStackView.addArrangedSubview(lastnameTextField)
        personalInfoStackView.addArrangedSubview(universityTextField)
        personalInfoStackView.addArrangedSubview(statusTextField)
        personalInfoStackView.axis = .vertical
        personalInfoStackView.spacing = 50.0
        
    }
    
    private func setupProfileLabel() {
        view.addSubview(titleLabel)
        view.addSubview(preferencesButton)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "Профиль"
        titleLabel.textColor = UIColor.hseBlue
        titleLabel.font = UIFont.systemFont(ofSize: 32.0, weight: .bold)
        
        titleLabel.heightAnchor.constraint(equalToConstant: 36.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: rightInset).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftInset).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60.0).isActive = true
        
        preferencesButton.translatesAutoresizingMaskIntoConstraints = false
        preferencesButton.setImage(UIImage(named: "preferences_icon"), for: .normal)
        preferencesButton.layer.masksToBounds = true
        preferencesButton.addTarget(self, action: #selector(preferencesButtonTapped), for: .touchUpInside)
        
        preferencesButton.heightAnchor.constraint(equalToConstant: 36.0).isActive = true
        preferencesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: rightInset).isActive = true
        preferencesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftInset + 360).isActive = true
        preferencesButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60.0).isActive = true
        
    }
    
    private func setupInfoStackView() {
        view.addSubview(infoScrollView)
        infoScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        infoScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: rightInset).isActive = true
        infoScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftInset).isActive = true
        infoScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 400).isActive = true
        infoScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        
        infoScrollView.addSubview(infoView)
        infoTextView.translatesAutoresizingMaskIntoConstraints = false
        //infoTextView.axis = .vertical
        //infoTextView.spacing = 10
        
        infoView.leadingAnchor.constraint(equalTo: infoScrollView.leadingAnchor).isActive = true
        infoView.topAnchor.constraint(equalTo: infoScrollView.topAnchor).isActive = true
        infoView.trailingAnchor.constraint(equalTo: infoScrollView.trailingAnchor).isActive = true
        infoView.bottomAnchor.constraint(equalTo: infoScrollView.bottomAnchor).isActive = true
        infoView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        infoView.addSubview(infoTextView)
        infoTextView.text = "Здесь вы можете кратко описать выши научные работы и прочие достижения"
        
    }
    
    @objc private func profileImageButtonTapped() {
        showImagePickerControllerActionSheet()
    }
    
    @objc private func preferencesButtonTapped() {
        navigationController?.pushViewController(PreferencesViewController(), animated: true)
        
    }
}
