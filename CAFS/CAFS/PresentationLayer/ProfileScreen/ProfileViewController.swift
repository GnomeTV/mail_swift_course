import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

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
            if var userInfo = model.getUserInfoFromCache() {
                model.addUserAvatar(user: userInfo, avatar: avatar) { result in
                    switch result {
                    case .success((_, let url)):
                        let imageURL = url.absoluteString
                        if !imageURL.isEmpty {
                            userInfo.avatar = imageURL
                            self.model.updateUserInfo(personalData: userInfo) { _ in
                            }
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
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
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
    private let saveButton = HseStyleButton()
    
    private let extraInfoStackView = UIStackView()
    private let extraContactTextField = UITextField()
    private let firstWorkNameTextField = UITextField()
    private let secondWorkNameTextField = UITextField()
    private let thirdWorkNameTextField = UITextField()
    
    // MARK: - Insets
    
    private let leftInset: CGFloat = 24.0
    private let rightInset: CGFloat = 24.0
    private let buttonHeight: CGFloat = 48.0
    private let topInsetTextFieldIndicator: CGFloat = 3.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.hideKeyboardWhenTappedAround()
        setupViews()
        updateUserInfoFields()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUserInfoFields()
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
        view.addSubview(profileImageStackView)
        profileImageStackView.addArrangedSubview(profileImageView)
        profileImageStackView.translatesAutoresizingMaskIntoConstraints = false
        profileImageStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: rightInset).isActive = true
        profileImageStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -screenWidth + 200 + leftInset).isActive = true
        profileImageStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 114.0).isActive = true
        profileImageStackView.bottomAnchor.constraint(equalTo: profileImageStackView.topAnchor, constant: 250).isActive = true
        
        
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
        personalInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        personalInfoStackView.leadingAnchor.constraint(equalTo: profileImageStackView.trailingAnchor, constant: 10).isActive = true
        personalInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftInset).isActive = true
        personalInfoStackView.topAnchor.constraint(equalTo: profileImageStackView.topAnchor).isActive = true
        personalInfoStackView.bottomAnchor.constraint(equalTo: personalInfoStackView.topAnchor, constant: 250).isActive = true
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        updateUserInfoFields()
        
        personalInfoStackView.addArrangedSubview(firstnameTextField)
        personalInfoStackView.addArrangedSubview(lastnameTextField)
        personalInfoStackView.addArrangedSubview(universityTextField)
        personalInfoStackView.addArrangedSubview(statusTextField)
        personalInfoStackView.addArrangedSubview(saveButton)
        personalInfoStackView.axis = .vertical
        personalInfoStackView.spacing = 30.0
        
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
        preferencesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenWidth - 50 - rightInset).isActive = true
        preferencesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftInset).isActive = true
        preferencesButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60.0).isActive = true
        
    }
    
    private func setupInfoStackView() {
        view.addSubview(extraInfoStackView)
        
        extraInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        extraInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: rightInset).isActive = true
        extraInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftInset).isActive = true
        extraInfoStackView.topAnchor.constraint(equalTo: profileImageStackView.bottomAnchor, constant: 20).isActive = true
        extraInfoStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300).isActive = true
        
        extraContactTextField.placeholder = "Дополнительный контакт"
        firstWorkNameTextField.placeholder = "Название первой работы"
        secondWorkNameTextField.placeholder = "Название второй работы"
        thirdWorkNameTextField.placeholder = "Название третьей работы"
        
        extraInfoStackView.addArrangedSubview(extraContactTextField)
        extraInfoStackView.addArrangedSubview(firstWorkNameTextField)
        extraInfoStackView.addArrangedSubview(secondWorkNameTextField)
        extraInfoStackView.addArrangedSubview(thirdWorkNameTextField)
        
        extraInfoStackView.axis = .vertical
        extraInfoStackView.spacing = 10.0
        
    }
    
    private func updateUserInfoFields() {
        if let userPersonalData = model.getUserInfoFromCache() {
            
            firstnameTextField.text = userPersonalData.firstName
            lastnameTextField.text = userPersonalData.lastName
            universityTextField.text = userPersonalData.university
            statusTextField.text = userPersonalData.status
            
            if userPersonalData.works.count != 0{
                extraContactTextField.text = userPersonalData.works[0]
                firstWorkNameTextField.text = userPersonalData.works[1]
                secondWorkNameTextField.text = userPersonalData.works[2]
                thirdWorkNameTextField.text = userPersonalData.works[3]
            }
            else {
                extraContactTextField.text = ""
                firstWorkNameTextField.text = ""
                secondWorkNameTextField.text = ""
                thirdWorkNameTextField.text = ""
            }
            
            
            DispatchQueue.main.async {
                self.model.getUserInfoFromServer(userData: userPersonalData) { [self] result in
                    switch result {
                    case .success(let pData):
                        firstnameTextField.text = pData.firstName
                        lastnameTextField.text = pData.lastName
                        universityTextField.text = pData.university
                        statusTextField.text = pData.status
                        model.updateUserInfoInCache(personalData: pData)
                    case .failure(let error):
                        print("Error: ", error)
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.model.getUserAvatar(user: userPersonalData) { result in
                    switch result {
                    case .success(let image):
                        self.profileImageView.image = image
                    case .failure(_):
                        print("Error download image")
                    }
                }
            }
        }
    }
    
    @objc private func profileImageButtonTapped() {
        showImagePickerControllerActionSheet()
    }
    
    @objc private func preferencesButtonTapped() {
        navigationController?.pushViewController(PreferencesViewController(), animated: true)
        
    }
    
    @objc private func saveButtonTapped() {
        if var userPersonalData = model.getUserInfoFromCache() {
            if userPersonalData.works.count != 4 {
                userPersonalData.works = ["", "", "", ""]
            }
            userPersonalData.works[0] = (extraContactTextField.text ?? "")
            userPersonalData.works[1] = (firstWorkNameTextField.text ?? "")
            userPersonalData.works[2] = (secondWorkNameTextField.text ?? "")
            userPersonalData.works[3] = (thirdWorkNameTextField.text ?? "")
            
            model.updateUserInfo(personalData: userPersonalData)  { _ in }
        }
        print("SaveButton tapped")
    }
    
}
