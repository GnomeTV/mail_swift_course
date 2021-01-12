import UIKit

extension String {
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
}

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

public extension UIView {
    func showAnimation(_ completionBlock: @escaping () -> Void) {
      isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveLinear,
                       animations: { [weak self] in
                            self?.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
        }) {  (done) in
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .curveLinear,
                           animations: { [weak self] in
                                self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { [weak self] (_) in
                self?.isUserInteractionEnabled = true
                completionBlock()
            }
        }
    }
}

extension ProfileViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == extraContactTextField {
            textField.resignFirstResponder()
            return true
        }
        
        if textField == firstWorkNameTextField ||
            textField == secondWorkNameTextField ||
            textField == thirdWorkNameTextField {
            if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
                nextField.becomeFirstResponder()
            }
        }
        
        if textField == firstWorkLinkTextField ||
            textField == secondWorkLinkTextField ||
            textField == thirdWorkLinkTextField {
            textField.resignFirstResponder()
            return true
        }
        return false
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


class ProfileViewController: UIViewController, UITextFieldDelegate {
    
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
    private let firstWorkLinkTextField = UITextField()
    private let firstLinkStatus = UILabel()
    private let secondWorkNameTextField = UITextField()
    private let secondWorkLinkTextField = UITextField()
    private let secondLinkStatus = UILabel()
    private let thirdWorkNameTextField = UITextField()
    private let thirdWorkLinkTextField = UITextField()
    private let thirdLinkStatus = UILabel()

    // MARK: - Insets
    
    private let leftInset: CGFloat = 24.0
    private let rightInset: CGFloat = 24.0
    private let buttonHeight: CGFloat = 48.0
    private let topInsetTextFieldIndicator: CGFloat = 3.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        extraContactTextField.delegate = self
        extraContactTextField.tag = 1
        firstWorkNameTextField.delegate = self
        firstWorkNameTextField.tag = 2
        firstWorkLinkTextField.delegate = self
        firstWorkLinkTextField.tag = 3
        secondWorkNameTextField.delegate = self
        secondWorkNameTextField.tag = 4
        secondWorkLinkTextField.delegate = self
        secondWorkLinkTextField.tag = 5
        thirdWorkNameTextField.delegate = self
        thirdWorkNameTextField.tag = 6
        thirdWorkLinkTextField.delegate = self
        thirdWorkLinkTextField.tag = 7
        
        view.backgroundColor = UIColor.screenBackground
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
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
        extraInfoStackView.topAnchor.constraint(equalTo: profileImageStackView.bottomAnchor, constant: 50).isActive = true
        //extraInfoStackView.bottomAnchor.constraint(equalTo: extraInfoStackView.topAnchor, constant: 7 * 22 + 60).isActive = true
        
        firstLinkStatus.isHidden = true
        secondLinkStatus.isHidden = true
        thirdLinkStatus.isHidden = true
        firstLinkStatus.textColor = UIColor.systemRed
        secondLinkStatus.textColor = UIColor.systemRed
        thirdLinkStatus.textColor = UIColor.systemRed
        
        extraContactTextField.placeholder = "Дополнительный контакт"
        firstWorkNameTextField.placeholder = "Название первой работы"
        firstWorkLinkTextField.placeholder = "Ссылка на первую работу"
        secondWorkNameTextField.placeholder = "Название второй работы"
        secondWorkLinkTextField.placeholder = "Ссылка на вторую работу"
        thirdWorkNameTextField.placeholder = "Название третьей работы"
        thirdWorkLinkTextField.placeholder = "Ссылка на третию работу"
        
        firstWorkNameTextField.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        secondWorkNameTextField.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        thirdWorkNameTextField.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        firstWorkLinkTextField.borderStyle = .line
        secondWorkLinkTextField.borderStyle = .line
        thirdWorkLinkTextField.borderStyle = .line
        
        extraInfoStackView.addArrangedSubview(extraContactTextField)
        extraInfoStackView.addArrangedSubview(firstWorkNameTextField)
        extraInfoStackView.addArrangedSubview(firstWorkLinkTextField)
        extraInfoStackView.addArrangedSubview(firstLinkStatus)
        extraInfoStackView.addArrangedSubview(secondWorkNameTextField)
        extraInfoStackView.addArrangedSubview(secondWorkLinkTextField)
        extraInfoStackView.addArrangedSubview(secondLinkStatus)
        extraInfoStackView.addArrangedSubview(thirdWorkNameTextField)
        extraInfoStackView.addArrangedSubview(thirdWorkLinkTextField)
        extraInfoStackView.addArrangedSubview(thirdLinkStatus)
        
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
                firstWorkLinkTextField.text = userPersonalData.works[2]
                secondWorkNameTextField.text = userPersonalData.works[3]
                secondWorkLinkTextField.text = userPersonalData.works[4]
                thirdWorkNameTextField.text = userPersonalData.works[5]
                thirdWorkLinkTextField.text = userPersonalData.works[6]
            }
            else {
                extraContactTextField.text = ""
                firstWorkNameTextField.text = ""
                firstWorkLinkTextField.text = ""
                secondWorkNameTextField.text = ""
                secondWorkLinkTextField.text = ""
                thirdWorkNameTextField.text = ""
                thirdWorkLinkTextField.text = ""
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
    
    @objc private func saveButtonTapped(sender: UIButton) {
        sender.showAnimation {
            if var userPersonalData = self.model.getUserInfoFromCache() {

                userPersonalData.works[0] = (self.extraContactTextField.text ?? "")
                userPersonalData.works[1] = (self.firstWorkNameTextField.text ?? "")
                userPersonalData.works[2] = (self.firstWorkLinkTextField.text ?? "")
                if self.firstWorkLinkTextField.text != "" {
                    if !(self.firstWorkLinkTextField.text?.isValidURL ?? true) {
                        self.firstLinkStatus.isHidden = false
                        self.firstLinkStatus.text = "Некорректная ссылка"
                    }
                }
                else {
                    self.firstLinkStatus.isHidden = true
                }
                
                userPersonalData.works[3] = (self.secondWorkNameTextField.text ?? "")
                userPersonalData.works[4] = (self.secondWorkLinkTextField.text ?? "")
                if self.secondWorkLinkTextField.text != "" {
                    if !(self.secondWorkLinkTextField.text?.isValidURL ?? true) {
                        self.secondLinkStatus.isHidden = false
                        self.secondLinkStatus.text = "Некорректная ссылка"
                    }
                }
                else {
                    self.secondLinkStatus.isHidden = true
                }
                
                userPersonalData.works[5] = (self.thirdWorkNameTextField.text ?? "")
                userPersonalData.works[6] = (self.thirdWorkLinkTextField.text ?? "")
                if self.thirdWorkLinkTextField.text != "" {
                    if !(self.thirdWorkLinkTextField.text?.isValidURL ?? true) {
                        self.thirdLinkStatus.isHidden = false
                        self.thirdLinkStatus.text = "Некорректная ссылка"
                    }
                }
                else {
                    self.thirdLinkStatus.isHidden = true
                }
                
                self.model.updateUserInfo(personalData: userPersonalData)  { _ in }
            }
            print("SaveButton tapped")
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        var keyboardHeight : CGFloat = 0
        if let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight += keyboardRect.height
        }
        let duration: TimeInterval = 0.5
        UIView.animate(withDuration: duration, animations: {
            
            if self.extraContactTextField.isEditing {
                self.firstWorkNameTextField.isHidden = true
                self.firstWorkLinkTextField.isHidden = true
                self.secondWorkNameTextField.isHidden = true
                self.secondWorkLinkTextField.isHidden = true
                self.thirdWorkNameTextField.isHidden = true
                self.thirdWorkLinkTextField.isHidden = true
            }
            else if self.firstWorkNameTextField.isEditing || self.firstWorkLinkTextField.isEditing {
                self.extraContactTextField.isHidden = true
                self.secondWorkNameTextField.isHidden = true
                self.secondWorkLinkTextField.isHidden = true
                self.thirdWorkNameTextField.isHidden = true
                self.thirdWorkLinkTextField.isHidden = true
            }
            else if self.secondWorkNameTextField.isEditing || self.secondWorkLinkTextField.isEditing {
                self.extraContactTextField.isHidden = true
                self.firstWorkNameTextField.isHidden = true
                self.firstWorkLinkTextField.isHidden = true
                self.thirdWorkNameTextField.isHidden = true
                self.thirdWorkLinkTextField.isHidden = true
            }
            else if self.thirdWorkNameTextField.isEditing || self.thirdWorkLinkTextField.isEditing {
                self.extraContactTextField.isHidden = true
                self.firstWorkNameTextField.isHidden = true
                self.firstWorkLinkTextField.isHidden = true
                self.secondWorkNameTextField.isHidden = true
                self.secondWorkLinkTextField.isHidden = true
            }
            
            }, completion: nil)
        if ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let duration: TimeInterval = 0.5
        UIView.animate(withDuration: duration, animations: {
            
            self.extraContactTextField.isHidden = false
            self.firstWorkNameTextField.isHidden = false
            self.firstWorkLinkTextField.isHidden = false
            self.secondWorkNameTextField.isHidden = false
            self.secondWorkLinkTextField.isHidden = false
            self.thirdWorkNameTextField.isHidden = false
            self.thirdWorkLinkTextField.isHidden = false
            
            }, completion: nil)
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
}
